# PNC Connect

PNC Connect is a Flutter application featuring a simple authentication flow, including Login, Sign-Up, and Home screens.

## Features

- **Login Screen** – Existing users can sign in to their account.
- **Sign-Up Screen** – New users can create an account.
- **Home Screen** – Landing page shown after successful authentication.

## Tech Stack

- [Flutter](https://flutter.dev/) (SDK ^3.0.0)
- [google_fonts](https://pub.dev/packages/google_fonts) – custom typography
- [flutter_svg](https://pub.dev/packages/flutter_svg) – SVG asset rendering
- [cupertino_icons](https://pub.dev/packages/cupertino_icons) – iOS-style icons

## Project Structure

```
lib/
├── main.dart
└── screens/
    ├── login_screen.dart
    ├── signup_screen.dart
    └── home_screen.dart
```

## Getting Started

1. Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
2. Clone this repository.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Notes

Before pushing changes, run `flutter clean` to remove build artifacts (`build/`, `.dart_tool/`) so they don't bloat the repository.
