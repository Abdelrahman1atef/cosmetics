# Cosmetics (Flutter)

## Screenshots

> Images below are taken from this repo so they render automatically on GitHub.

### Splash

| App icon | Splash illustration |
|---|---|
| ![App icon](assets/icons/app_icon.svg) | ![Splash](assets/icons/splash_image2.svg) |

### Auth (Login / Register / OTP / Success)

| Login | Register | OTP Verify | Success dialog |
|---|---|---|---|
| ![Login](assets/images/login.png) | ![Register](docs/screenshots/auth_register.png) | ![OTP verify](docs/screenshots/auth_otp.png) | ![Success dialog](docs/screenshots/auth_success.png) |

### Home (Tabs) + Checkout

| Home | Categories | Cart | Profile |
|---|---|---|---|
| ![Home](docs/screenshots/home_tab_home.png) | ![Categories](docs/screenshots/home_tab_categories.png) | ![Cart](docs/screenshots/home_tab_cart.png) | ![Profile](docs/screenshots/home_tab_profile.png) |

| Checkout |
|---|
| ![Checkout](docs/screenshots/checkout.png) |

### Onboarding

| Onboarding 1 | Onboarding 2 | Onboarding 3 |
|---|---|---|
| ![Onboarding 1](assets/images/on_boarding1.png) | ![Onboarding 2](assets/images/on_boarding2.png) | ![Onboarding 3](assets/images/on_boarding3.png) |

> Note: the `docs/screenshots/*.png` files are placeholders. Add real screenshots with the same filenames to make them appear here.

Mobile cosmetics e-commerce UI built with Flutter: onboarding + authentication (register/login/OTP) and a tabbed home experience (Home, Categories, Cart, Profile), with a checkout screen.

## Features

- **Onboarding flow**: 3-step onboarding with skip / continue
- **Authentication**
  - Register (name, email, phone, password)
  - Login (phone + password)
  - OTP verification screen (register + forgot password flows)
  - Forgot password → verify OTP → reset password
- **Home (Bottom tabs)**: Home, Categories, Cart, Profile
- **Cart & Checkout UI**: cart list, totals summary, and checkout screen
- **Networking layer**: `Dio` + `PrettyDioLogger`
- **Local storage**: token persisted in `SharedPreferences`
- **Assets**: SVG icons, custom fonts (Segoe + Montserrat), onboarding/login images

## Tech Stack

- **Flutter SDK**: `>= 3.10.0` (see `pubspec.yaml`)
- **State management**: `flutter_bloc` (present in dependencies)
- **Networking**: `dio`, `pretty_dio_logger`
- **UI helpers**: `flutter_svg`, `flutter_screenutil`, `pin_code_fields`
- **Codegen**: `json_serializable`, `freezed`, `build_runner` (dev deps)

## Getting Started

### Prerequisites

- Flutter installed and set up (`flutter doctor`)
- Android Studio / VS Code + Flutter plugin
- Android emulator or physical device (or iOS Simulator on macOS)

### Install

```bash
flutter pub get
```

### Run (Debug)

```bash
flutter run
```

### Build

- Android APK:

```bash
flutter build apk
```

- Android App Bundle (Play Store):

```bash
flutter build appbundle
```

## Backend / API

The app is configured to talk to a backend API.

- **Base URL**: `http://www.cosmatics.growfet.com/`
- **Where it is set**: `lib/core/network/dio_helper.dart`
- **Auth endpoints used in the UI**
  - `api/Auth/register`
  - `api/Auth/login`
  - `api/Auth/verify-otp`
  - `api/Auth/forgot-password`
  - `api/Auth/reset-password`

### Auth token storage

- After login, the token is stored in `SharedPreferences` under the key `token`.

## Project Structure (high level)

```text
lib/
  core/
    logic/          # navigation helpers + snackbars
    network/        # Dio + API configuration
    widgets/        # reusable UI widgets
  features/
    auth/           # auth models (register)
  views/
    splash.dart
    on_boarding.dart
    login.dart
    register.dart
    verify_code.dart
    forget_password.dart
    create_password.dart
    check_out.dart
    home/
      view.dart     # bottom tabs
      pages/        # home, categories, cart, profile
assets/
  images/
  icons/
  fonts/
```

## Code Generation (Freezed / JSON)

If you edit any `freezed` / `json_serializable` models, regenerate files with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Notes / Known Limitations

- **OTP value**: the verify screen currently submits a hardcoded OTP (`"1111"`) in `lib/views/verify_code.dart`.
- **Some screens use demo/static data** (e.g., product lists / cart items) and include `TODO` comments for API wiring.

## Contributing

Pull requests are welcome. If you plan a bigger change, open an issue first to discuss it.

## License

This project currently does not include a license file. If you want it to be open-source, add a `LICENSE` (MIT/Apache-2.0/etc.).
