# Welcome to flutter-apprentice 👋
[![Twitter: jellydn](https://img.shields.io/twitter/follow/jellydn.svg?style=social)](https://twitter.com/jellydn)

> Learn Flutter with https://www.raywenderlich.com/books/flutter-apprentice/v2.0

## Amp orb setup

Run `.agents/setup` from an x86_64 Linux orb to install the verified `recipes`
toolchain: Flutter 2.2.3 (Dart 2.13.4), Temurin JDK 11, Gradle 6.7, and Android
SDK platform 30 with build-tools 29.0.2. Toolchain archives have pinned SHA-256
checksums. The script caches Android artifacts and runs `flutter pub get` on a
temporary copy of the `recipes` dependency manifests. This preserves the
checkout's lockfile when the older SDK selects its test dependencies. Setup
does not install an emulator or create signing credentials.

Tools are stored in `~/.local/share/flutter-apprentice`. New login shells in
this checkout and its subdirectories load the tool paths and Android SDK
variables. Setup can be run again; installed tools are reused. No resume script
is needed because setup starts no services and requires no authentication.

After setup, start a new login shell and run the signing checks from the root:

```sh
python3 recipes/tool/check_release_signing.py
```

See [recipes release signing](recipes/README.md#android-release-signing) for
secure signing setup and the legacy release-lint workaround. This toolchain is
verified for `recipes` only. The other apps have different locked dependency
requirements and are not changed by orb setup.

## Author

👤 **Dung Huynh**

* Website: https://productsway.com/
* Twitter: [@jellydn](https://twitter.com/jellydn)
* Github: [@jellydn](https://github.com/jellydn)

## Show your support

Give a ⭐️ if this project helped you!


***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
