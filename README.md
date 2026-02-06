
# Ozone Mobile Application

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-orange)

Ozone is a production‑ready **Flutter cross‑platform mobile application** designed to provide scalable healthcare and pharmacy services with secure authentication, API integrations, and high‑performance UI.

---

## 📱 Application Overview
This repository contains the **complete production source code** including:
- Modular feature‑based architecture
- Shared core utilities and networking layer
- Firebase integrations (Auth, FCM)
- REST API integration
- Android & iOS production configurations

---

## 🧱 System Architecture

## 🧩 Architecture Diagram

![Clean Architecture Diagram](./docs/ozone_clean_architecture.png)

### Clean Architecture Layers
```
Presentation Layer
   ↓
Domain Layer
   ↓
Data Layer
```

### Project Structure
```
lib/
 ├── core/
 │    ├── networking/
 │    ├── constants/
 │    ├── theme/
 │    └── utils/
 │
 ├── features/
 │    ├── auth/
 │    ├── home/
 │    ├── orders/
 │    ├── profile/
 │    └── notifications/
 │
 ├── services/
 │    ├── api_services/
 │    ├── firebase_services/
 │    └── storage_services/
 │
 ├── widgets/
 │    └── shared/
 │
 └── main.dart
```

---

## 🚀 Features
- Android & iOS cross‑platform application
- Secure authentication and session handling
- REST API integration
- Firebase Push Notifications (FCM)
- PDF Upload & Download
- Optimized performance and responsive UI
- Production‑ready deployment setup

---

## 📸 Screenshots
(Add screenshots here)

```
assets/screenshots/
   home.png
   login.png
   profile.png
```

---

## 🛠 Technology Stack
- Flutter (Dart)
- Firebase (Auth, FCM)
- REST APIs
- Clean Architecture
- GitHub CI/CD Ready

---

## ⚙️ Setup

```bash
git clone https://github.com/MysteryBuilders/ozone.git
cd ozone
flutter pub get
flutter run
```

---

## 🏗 Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

---

## 📦 Deployment
- Google Play Store
- Apple App Store

---

## 👨‍💻 Maintainer
**Mohammed Elshwehy**  
Senior Mobile Application Developer (Flutter / Android / iOS)

---
