# recipes

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android release signing

Release APKs and app bundles use a private release keystore. They never fall back
to the Android debug key. Debug and profile builds, and IDE sync, do not need
release credentials. Release builds fail with a setup message if a required
property is empty or the keystore file does not exist. Android's signing tools
check the keystore password and alias when signing the artifact.

### Set up a local release key

1. Use the existing upload key for an app that is already published. Do not
   replace it with a new key. For a new app, create a key outside this repository:

   ```sh
   keytool -genkeypair -v -keystore "$HOME/recipes-upload.jks" \
     -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   Enter the passwords at the prompts. Do not put passwords in shell commands
   or shell history. Store the key and passwords in secure, separate backups.

2. From `recipes`, copy the blank template:

   ```sh
   cp android/key.properties.example android/key.properties
   chmod 600 android/key.properties
   ```

3. Fill in all four fields in `android/key.properties`: `storeFile`,
   `storePassword`, `keyAlias`, and `keyPassword`. The `storeFile` value is an
   absolute path, or a path relative to **recipes/android**, not `android/app`.
   Do not use `~` or shell variables in this file. Use forward slashes on Windows.
   This is a Java properties file: escape literal backslashes as `\\` and use
   `\uXXXX` escapes for non-ASCII characters.

4. With the project's Flutter and Android toolchains installed, build from
   `recipes`:

   ```sh
   flutter pub get
   flutter build apk --release
   flutter build appbundle --release
   ```

`android/key.properties`, `*.jks`, and `*.keystore` are already ignored by Git
under `android`. Keep the keystore outside the repository, and commit only the
blank `.example` template. Do not add signing passwords to Gradle files or logs.

### CI and verification

In CI, restore the keystore and generate `android/key.properties` from the CI
secret store only in a trusted release job. Restrict file access to the job user.
Do not expose release secrets to pull requests from forks, print the properties,
or cache/upload these files as artifacts. Delete them after the job, including
when the build fails. No signing credentials are stored in this repository.

The build checks use the real Android Gradle project in a temporary copy. They
generate a disposable key and test missing/blank credentials, a missing keystore,
APK/bundle/aggregate release task graphs, debug/profile configuration without
secrets, and release certificate selection with absolute and relative paths.
They do not compile an APK or bundle. Run from `recipes` with Python 3.8+, a
compatible Flutter SDK (Flutter 2.2.3), JDK 11,
Android SDK platform 30/build-tools 29.0.2, and
Gradle 6.7 on `PATH`. Set `ANDROID_SDK_ROOT` to the Android SDK directory:

```sh
python3 tool/check_release_signing.py
```

Flutter 2.10.5 adds an Android dependency that requires compile SDK 31. This
project uses compile SDK 30; use Flutter 2.2.3 for full builds until the Android
toolchain is upgraded separately.

With the legacy Android Gradle plugin, `lintVitalRelease` can report a missing
`flutter/profile/libs.jar` on a clean build. Run `flutter build apk --profile`
before retrying the release build. Do not disable release lint to bypass it.

For a full artifact check, run the release build commands above, then use the
Android SDK's `apksigner verify --print-certs` on
`build/app/outputs/flutter-apk/app-release.apk`. Compare its signer SHA-256
fingerprint with `keytool -list -v -keystore <your-keystore> -alias <your-alias>`.
The fingerprints must match your release key, not the debug certificate.
