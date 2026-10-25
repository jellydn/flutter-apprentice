"""Exercise the real Android Gradle configuration in a disposable project copy."""

import os
from pathlib import Path
import secrets
import shutil
import subprocess
import tempfile
import unittest


class ReleaseSigningChecks(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix="recipes-signing-")
        cls.addClassCleanup(cls.temp.cleanup)
        cls.project = Path(cls.temp.name) / "recipes"
        shutil.copytree(
            Path(__file__).resolve().parents[1],
            cls.project,
            ignore=shutil.ignore_patterns(
                "build", ".gradle", ".dart_tool", ".packages", "local.properties",
                "key.properties", "*.jks", "*.keystore",
            ),
        )
        flutter = Path(shutil.which("flutter")).resolve().parents[1]
        sdk = os.environ["ANDROID_SDK_ROOT"]
        (cls.project / "android/local.properties").write_text(
            f"flutter.sdk={flutter.as_posix()}\nsdk.dir={Path(sdk).as_posix()}\n"
        )
        result = subprocess.run(
            ["flutter", "pub", "get"], cwd=cls.project,
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True,
        )
        if result.returncode:
            raise RuntimeError(result.stdout)
        cls.password = secrets.token_hex(16)
        cls.key_password = secrets.token_hex(16)
        cls.keystore = Path(cls.temp.name) / "release-test.jks"
        subprocess.run(
            [
                "keytool", "-genkeypair", "-noprompt", "-storetype", "JKS",
                "-keystore", str(cls.keystore), "-alias", "release-test",
                "-keyalg", "RSA", "-keysize", "2048", "-validity", "1",
                "-dname", "CN=Disposable Signing Test",
                "-storepass:env", "SIGNING_TEST_PASSWORD",
                "-keypass:env", "SIGNING_TEST_KEY_PASSWORD",
            ],
            env={
                **os.environ, "SIGNING_TEST_PASSWORD": cls.password,
                "SIGNING_TEST_KEY_PASSWORD": cls.key_password,
            },
            stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True,
        )

    def setUp(self):
        self.properties = self.project / "android/key.properties"
        self.properties.unlink(missing_ok=True)

    def configure(self, **overrides):
        properties = {
            "storeFile": self.keystore.as_posix(),
            "storePassword": self.password,
            "keyAlias": "release-test",
            "keyPassword": self.key_password,
        }
        properties.update(overrides)
        self.properties.write_text("".join(
            f"{key}={value}\n" for key, value in properties.items()
            if value is not None
        ))

    def gradle(self, *tasks, error=None, dry_run=True):
        command = [
            "gradle", "--console=plain", "--max-workers=2", "-p",
            str(self.project / "android"), *tasks,
        ]
        if dry_run:
            command.append("--dry-run")
        result = subprocess.run(
            command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True,
        )
        # A failed configuration must name the problem, not expose credentials.
        self.assertNotIn(self.password, result.stdout)
        self.assertNotIn(self.key_password, result.stdout)
        if error:
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertIn(error, result.stdout)
        else:
            self.assertEqual(result.returncode, 0, result.stdout)
            self.assertIn("BUILD SUCCESSFUL", result.stdout)
        return result.stdout

    def test_debug_profile_and_sync_without_credentials(self):
        self.gradle(":app:assembleDebug", ":app:assembleProfile", "help")

    def test_release_tasks_without_credentials(self):
        for task in (":app:assembleRelease", ":app:bundleRelease", "assemble"):
            with self.subTest(task=task):
                self.gradle(task, error="Release signing requires android/key.properties")

    def test_each_required_property_missing_or_blank(self):
        for key in ("storeFile", "storePassword", "keyAlias", "keyPassword"):
            for value in (None, "   "):
                with self.subTest(key=key, value=value):
                    self.configure(**{key: value})
                    self.gradle(":app:assembleRelease", error=f"non-empty: {key}.")

    def test_missing_keystore(self):
        self.configure(storeFile="missing.jks")
        self.gradle(":app:bundleRelease", error="requires an existing keystore file")

    def test_absolute_and_android_relative_paths(self):
        for path in (self.keystore.as_posix(), "../../release-test.jks"):
            with self.subTest(path=path):
                self.configure(storeFile=path)
                self.gradle(":app:assembleRelease", ":app:bundleRelease")
                report = self.gradle(":app:signingReport", dry_run=False)
                release = report.split("Variant: release\n", 1)[1].split("----------", 1)[0]
                self.assertIn("Config: release", release)
                self.assertIn(f"Store: {self.keystore}", release)
                self.assertIn("Alias: release-test", release)
                self.assertIn("SHA-256:", release)
                self.assertNotIn("Error:", release)


if __name__ == "__main__":
    unittest.main(verbosity=2)
