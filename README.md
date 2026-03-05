# Mwanga Hakika Bank - Mobile App

A beautiful, modern Flutter mobile application for the Mwanga Hakika Bank digital wallet system. This app connects to the Spring Boot backend API to provide complete banking functionality.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Dart](https://img.shields.io/badge/Dart-3.x-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📱 Features

### User Features

- **User Registration** - Create new account with full name, email, and password
- **Secure Login** - JWT-based authentication with token persistence
- **Wallet Balance** - View current account balance in TZS
- **Transfer Funds** - Send money to other users by their email
- **Request Top-Up** - Request wallet top-up via payment method
- **Transaction History** - View complete transaction history with pagination
- **Pull-to-Refresh** - Refresh data with pull gesture

### Admin Features

- **Dashboard** - View pending top-up requests
- **Approve Requests** - Approve user top-up requests and add funds
- **Reject Requests** - Reject invalid top-up requests
- **Direct Top-Up** - Add funds directly to any user's wallet

---

## 🏗️ Architecture

The app follows **Clean Architecture** with proper separation of concerns:

```
lib/
├── config/
│   └── app_config.dart          # API configuration & endpoints
├── models/
│   ├── user_model.dart           # User & AuthResponse models
│   └── wallet_model.dart         # Wallet, Transaction, TopUpRequest models
├── providers/
│   ├── auth_provider.dart        # Authentication state management
│   └── wallet_provider.dart      # Wallet state management
├── screens/
│   ├── login_screen.dart          # Login page
│   ├── register_screen.dart      # Registration page
│   ├── home_screen.dart          # Main dashboard
│   ├── transfer_screen.dart      # Transfer funds
│   ├── topup_screen.dart         # Request top-up
│   ├── transactions_screen.dart  # Transaction history
│   └── admin_screen.dart         # Admin panel
├── services/
│   └── api_service.dart          # HTTP client for backend
└── main.dart                     # App entry point
```

---

## 🚀 Getting Started

### Prerequisites

Before running the app, ensure you have:

1. **Flutter SDK 3.0+** - [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Backend Running** - Start the Spring Boot backend (see backend README)
3. **Android Studio / VS Code** - Recommended IDEs
4. **Physical Device or Emulator** - For testing

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/CEO-LAYSON/wallet_app.git
   cd wallet_app
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**

```bash
flutter build apk --release
```

**iOS (macOS only):**

```bash
flutter build ios --release
```

**Web:**

```bash
flutter build web
```

---

## ⚙️ Configuration

### API Base URL

The app connects to the backend API. Configure the URL in:

**File:** `lib/config/app_config.dart`

```dart
static const String apiBaseUrl = 'http://10.0.2.2:8080/api/v1';
```

### Changing the URL

| Environment      | URL                              | Description                     |
| ---------------- | -------------------------------- | ------------------------------- |
| Android Emulator | `http://10.0.2.2:8080/api/v1`    | 10.0.2.2 reaches host localhost |
| iOS Simulator    | `http://localhost:8080/api/v1`   | Use localhost                   |
| Physical Device  | `http://192.168.x.x:8080/api/v1` | Use your PC's local IP          |

**To find your PC's IP:**

- **Windows:** Run `ipconfig` in cmd
- **Mac/Linux:** Run `ifconfig` in terminal

---

## 📋 API Endpoints

The app uses the following backend endpoints:

| Endpoint                                    | Method | Description          |
| ------------------------------------------- | ------ | -------------------- |
| `/api/v1/auth/register`                     | POST   | Register new user    |
| `/api/v1/auth/login`                        | POST   | User login           |
| `/api/v1/wallet/balance`                    | GET    | Get wallet balance   |
| `/api/v1/wallet/transfer`                   | POST   | Transfer funds       |
| `/api/v1/wallet/topup-request`              | POST   | Request top-up       |
| `/api/v1/wallet/transactions`               | GET    | Get transactions     |
| `/api/v1/admin/wallet/topup`                | POST   | Admin direct top-up  |
| `/api/v1/admin/topup-requests`              | GET    | Get pending requests |
| `/api/v1/admin/topup-requests/{id}/approve` | POST   | Approve request      |
| `/api/v1/admin/topup-requests/{id}/reject`  | POST   | Reject request       |

---

## 🔐 Default Credentials

### Admin Account

```
Email: admin@mwanga.co.tz
Password: admin123
```

### Test User

Register a new user through the app's registration screen.

---

## 🎨 UI/UX Features

The app includes:

- **Beautiful Gradient Cards** - Modern wallet balance display
- **Material Design 3** - Following latest design guidelines
- **Responsive Layout** - Works on various screen sizes
- **Loading States** - Proper loading indicators
- **Error Handling** - User-friendly error messages
- **Pull-to-Refresh** - Refresh data easily
- **Bottom Navigation** - Easy navigation for admin users

---

## 🛠️ Technology Stack

| Category         | Technology         |
| ---------------- | ------------------ |
| Framework        | Flutter 3.x        |
| Language         | Dart 3.x           |
| State Management | Provider           |
| HTTP Client      | http package       |
| Local Storage    | SharedPreferences  |
| Architecture     | Clean Architecture |

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  http: ^1.1.0
  shared_preferences: ^2.2.2
  google_fonts: ^6.1.0
```

---

## 📂 Project Structure

```
wallet_app/
├── lib/
│   ├── config/
│   │   └── app_config.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── wallet_model.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── wallet_provider.dart
│   ├── screens/
│   │   ├── admin_screen.dart
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── topup_screen.dart
│   │   ├── transactions_screen.dart
│   │   └── transfer_screen.dart
│   ├── services/
│   │   └── api_service.dart
│   └── main.dart
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 👤 Author

**Layson CEO**

- GitHub: [@CEO-LAYSON](https://github.com/CEO-LAYSON)

---

## 🙏 Acknowledgments

- Mwanga Hakika Bank - Technical Interview Project
- Flutter Documentation
- Spring Boot Backend Team

---

## 📞 Support

For issues or questions:

1. Check the [Issues](https://github.com/CEO-LAYSON/wallet_app/issues) page
2. Ensure backend is running on `http://localhost:8080`
3. Verify API URL in `lib/config/app_config.dart`

---

**Happy Coding! 🚀**
