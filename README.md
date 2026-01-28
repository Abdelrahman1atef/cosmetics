# Cosmetics (Flutter)
# 💄 Cosmetics

**Cosmetics E-Commerce Mobile App (Flutter UI + API Integration)**

A modern cosmetics shopping application built with **Flutter**, featuring a complete **authentication flow**, **tab-based navigation**, and **checkout experience**.  
The project demonstrates clean UI implementation, API integration, and scalable project structure suitable for real-world e-commerce apps.

<p align="center">
  <img src="https://github.com/user-attachments/assets/23d9d2c8-a580-4b25-84f1-29260fe5b6a9" width="280"/>
</p>

---

## ✨ Features

### 🔐 Onboarding & Authentication
- 3-step onboarding flow with skip / continue
- User registration (name, email, phone, password)
- Login using phone number and password
- OTP verification (registration & forgot password)
- Forgot password → OTP verification → reset password
- Success dialogs and confirmations

### 🏠 Home Experience
- Bottom navigation tabs:
  - Home
  - Categories
  - Cart
  - Profile
- Clean and responsive UI for all tabs

### 🛒 Cart & Checkout
- Cart items list with totals summary
- Checkout screen with order overview
- Prepared for payment flow integration

### 🌐 Networking & Storage
- REST API integration using **Dio**
- Request/response logging with **PrettyDioLogger**
- Authentication token persisted using **SharedPreferences**

---

## 📱 Screenshots

### 🚀 Splash
| Splash |
| --- |
| <img src="https://github.com/user-attachments/assets/11c43967-6a5f-43b4-b08f-8c15e7b46952" width="160"/> |

---

### 🔐 Authentication Flow
| Login | Register | OTP Verify | Success |
| --- | --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/1b3f96a8-b9e1-4f74-8aca-419bdecaa317" width="160"/> | <img src="https://github.com/user-attachments/assets/5820ff50-a789-4b69-b9b3-fe7387d2e9d4" width="160"/> | <img src="https://github.com/user-attachments/assets/086dc57a-17a8-429d-b590-16ca08a038e2" width="160"/> | <img src="https://github.com/user-attachments/assets/4a0916e4-4434-4005-8d62-faf522b1b176" width="160"/> |

---

### 🏠 Home & Checkout
| Home | Categories | Cart | Profile |
| --- | --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/23d9d2c8-a580-4b25-84f1-29260fe5b6a9" width="160"/> | <img src="https://github.com/user-attachments/assets/6328395e-5a1a-46ff-a67a-a985a3f3c5ee" width="160"/> | <img src="https://github.com/user-attachments/assets/37514c91-35bf-406c-92d7-095841c8a6b4" width="160"/> | <img src="https://github.com/user-attachments/assets/15c6940c-f588-41d0-adfb-cacca126e51a" width="160"/> |

| Checkout |
| --- |
| <img src="https://github.com/user-attachments/assets/ae2fa961-15c8-4609-92a7-86b981038148" width="160"/> |

---

## 🧱 Project Structure

```text
lib/
├── core/
│   ├── logic/        # Navigation helpers & snackbars
│   ├── network/      # Dio setup & API configuration
│   ├── widgets/      # Reusable UI components
│
├── features/
│   └── auth/         # Authentication models
│
├── views/
│   ├── splash.dart
│   ├── on_boarding.dart
│   ├── login.dart
│   ├── register.dart
│   ├── verify_code.dart
│   ├── forget_password.dart
│   ├── create_password.dart
│   ├── check_out.dart
│   └── home/
│       ├── view.dart
│       └── pages/    # Home, Categories, Cart, Profile
│
assets/
├── images/
├── icons/
└── fonts/
```
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
