# 🛒 OZON E-Commerce Mobile Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/BLoC-Pattern-blue?style=for-the-badge" alt="BLoC"/>
  <img src="https://img.shields.io/badge/Clean_Architecture-green?style=for-the-badge" alt="Clean Architecture"/>
  <img src="https://img.shields.io/badge/Magento_2-API-orange?style=for-the-badge" alt="Magento 2"/>
</p>

<p align="center">
  A full-featured pharmacy e-commerce mobile application built with <strong>Flutter</strong> following <strong>Clean Architecture</strong> principles. Supports Android & iOS with Arabic/English localization and RTL layout.
</p>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Features](#-features)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [Code Generation](#-code-generation)
- [State Management](#-state-management)
- [API Layer](#-api-layer)
- [Navigation](#-navigation)
- [Localization](#-localization)
- [Adding New Features](#-adding-new-features)
- [Coding Conventions](#-coding-conventions)
- [Codebase Stats](#-codebase-stats)

---

## 📖 Overview

| Field | Details |
|-------|---------|
| **App Name** | OZON Pharmacy |
| **Platform** | Flutter (Android & iOS) |
| **Backend** | Magento 2 REST API |
| **Architecture** | Clean Architecture (Data / Domain / Presentation) |
| **State Management** | BLoC Pattern |
| **Payment** | MyFatoorah Gateway |
| **Localization** | Arabic 🇰🇼 & English 🇺🇸 (RTL/LTR) |
| **Push Notifications** | Firebase Cloud Messaging |

---

## 🛠 Tech Stack

### Core
| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management (BLoC pattern) |
| `dio` | HTTP client with interceptors |
| `retrofit` | Type-safe REST API definitions |
| `get_it` | Dependency injection (service locator) |
| `dartz` | Functional programming (`Either<Failure, T>`) |

### Data & Storage
| Package | Purpose |
|---------|---------|
| `json_serializable` | JSON serialization code generation |
| `shared_preferences` | Local key-value storage |
| `equatable` | Value equality for BLoC states/events |

### UI & UX
| Package | Purpose |
|---------|---------|
| `flutter_screenutil` | Responsive screen adaptation |
| `easy_localization` | i18n with Arabic/English support |
| `lottie` | Loading & empty state animations |
| `google_maps_flutter` | Location picker for addresses |
| `carousel_slider` | Home screen image sliders |

### Firebase
| Package | Purpose |
|---------|---------|
| `firebase_core` | Firebase initialization |
| `firebase_messaging` | Push notifications (FCM) |
| `flutter_local_notifications` | Foreground notification display |

---

## 🏗 Architecture

The app follows **Clean Architecture** with three distinct layers:

```
┌─────────────────────────────────────────────┐
│              PRESENTATION LAYER             │
│   Views • BLoCs • Widgets • Resources       │
├─────────────────────────────────────────────┤
│                DOMAIN LAYER                 │
│   Models • Use Cases • Repository Interface │
├─────────────────────────────────────────────┤
│                 DATA LAYER                  │
│   API Client • Responses • Mappers • Repos  │
└─────────────────────────────────────────────┘
```

### Data Flow

```
User Action → BLoC Event → Use Case → Repository → Data Source → API
API Response → Response Model → Mapper → Domain Model → BLoC State → UI
```

### Error Handling

All repository methods return `Either<Failure, T>` from the `dartz` package. BLoCs handle both cases using `fold()`:

```dart
(await useCase.execute(input)).fold(
  (failure) => emit(FeatureFailure(message: failure.message)),
  (data) => emit(FeatureSuccess(data: data)),
);
```

---

## 📁 Project Structure

```
lib/
├── app/                          # App core configuration
│   ├── app.dart                  # MyApp singleton with MaterialApp
│   ├── di.dart                   # Dependency injection (GetIt)
│   ├── constants.dart            # App constants, base URL, API keys
│   ├── app_prefrences.dart       # SharedPreferences wrapper
│   ├── user_prefrences.dart      # User-specific preferences
│   ├── extensions.dart           # Null-safety extensions
│   └── functions.dart            # Utility functions
│
├── data/                         # Data layer
│   ├── network/
│   │   ├── app_api.dart          # Retrofit API endpoint definitions
│   │   ├── app_api.g.dart        # Generated Retrofit implementation
│   │   ├── dio_factory.dart      # Dio client configuration
│   │   ├── error_handler.dart    # Error classification
│   │   ├── failure.dart          # Failure model
│   │   ├── network_info.dart     # Connectivity checker
│   │   └── helper_query.dart     # Query builder helpers
│   ├── response/                 # API response models (80 files)
│   ├── mapper/                   # Response → Domain mappers (28 files)
│   ├── data_source/
│   │   ├── remote_data_source.dart
│   │   └── local_data_source.dart
│   ├── repository/               # Repository implementations
│   ├── request/                  # Request models
│   └── services/                 # Additional services
│
├── domain/                       # Domain layer
│   ├── model/                    # Domain models (43 files)
│   ├── repository/
│   │   └── repository.dart       # Repository interface (abstract)
│   └── usecases/                 # Use cases (49 files)
│       └── base_usecase.dart     # BaseUseCase<Input, Output>
│
├── presentation/                 # Presentation layer (40+ modules)
│   ├── splash/                   # App launch & config
│   ├── login/                    # Authentication
│   ├── register/                 # Registration
│   ├── main/                     # Hub: Home, Cart, Profile, Offers
│   │   ├── bloc/                 # 28 BLoCs
│   │   └── view/
│   │       ├── main_view.dart    # Bottom navigation
│   │       ├── home_view.dart    # Dynamic home screen
│   │       ├── cart_view.dart    # Shopping cart
│   │       └── home_widget/      # Home widgets (slider, brands, etc.)
│   ├── categories/               # Category browsing
│   ├── products/                 # Product listing with sort/filter
│   ├── product_details/          # Product info, gallery, stock
│   ├── check_out/                # Checkout flow
│   ├── payment/                  # MyFatoorah payment
│   ├── my_orders/                # Order history
│   ├── wishlist/                 # Favorites
│   ├── addresses/                # Address management
│   ├── edit_profile/             # Profile editing
│   ├── brands/                   # Brand browsing
│   ├── search/                   # Product search
│   ├── contact_us/               # Support form
│   ├── resources/                # Shared resources
│   │   ├── routes_manager.dart   # 40+ named routes
│   │   ├── theme_manager.dart    # App theme (Montserrat)
│   │   ├── color_manager.dart    # Color constants
│   │   ├── strings_manager.dart  # Localization keys
│   │   └── ...                   # fonts, styles, assets, values
│   └── widgets/                  # Reusable widgets
│       ├── custom_app_bar.dart
│       ├── custom_button.dart
│       ├── product_widget.dart
│       └── ...
│
├── firebase_options.dart         # Firebase config (auto-generated)
└── main.dart                     # Entry point
```

---

## ✨ Features

### 🔐 Authentication
- Email/password login & registration
- Forgot password / reset password flow
- Guest browsing support
- Session management with token persistence

### 🏠 Home Screen
- Dynamic widget rendering from API (sliders, categories, products, brands)
- Countdown timer widgets
- Before/after comparison widgets
- Pull-to-refresh

### 🛍 Shopping
- Category tree browsing with subcategories
- Product listing with sort & filter
- Product detail view with image gallery & zoom
- Real-time stock checking
- Product search

### 🛒 Cart & Checkout
- Add/update/remove cart items
- Coupon code application & removal
- Shipping method estimation
- Multiple payment methods
- MyFatoorah payment gateway integration
- Invoice generation

### 📦 Orders
- Order history with status tracking
- Order detail view with timeline
- Order cancellation

### ❤️ Wishlist
- Add/remove products from favorites
- Wishlist product listing

### 👤 Profile
- View & edit profile information
- Profile image upload
- Password change
- Account deletion

### 📍 Addresses
- Address list management (CRUD)
- Google Maps location picker
- Country/state/city selection
- Default address setting

### 🏷 Brands
- Brand listing & browsing
- Brand-filtered product views

### 🌐 Localization
- Arabic (default) & English
- Full RTL/LTR layout support
- Dynamic locale switching

### 🔔 Notifications
- Firebase Cloud Messaging (FCM)
- Foreground & background notification handling
- Local notification display

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code
- Xcode (for iOS builds)
- Firebase CLI (for Firebase setup)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-org/ozon-app.git
cd ozon-app

# 2. Install dependencies
flutter pub get

# 3. Generate code (response models, retrofit)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Firebase Setup

1. Install Firebase CLI and FlutterFire CLI
2. Run `flutterfire configure` to generate `firebase_options.dart`
3. Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are in place

---

## ⚙️ Configuration

### API Configuration

Edit `lib/app/constants.dart`:

```dart
class Constants {
  static const String baseUrl = "https://ozone-pharmacy.com/rest/";
  static const String paymentUrl = "https://myacad.app/index.php";
  static const String privacyUrl = "https://ozone-pharmacy.com/privacy-policy/";
  static const int apiTimeOut = 60000; // 60 seconds
}
```

### Headers

The Dio client (`dio_factory.dart`) automatically injects:

| Header | Description |
|--------|-------------|
| `Authorization` | Bearer token for authenticated requests |
| `state-id` | Selected state/region ID |
| `store-code` | Store locale code (e.g., `ar`, `en`) |
| `device-type` | `Android` or `IOS` |
| `source-code` | Inventory source code |
| `store` | Store identifier |

---

## 🔄 Code Generation

The project uses `build_runner` for code generation. Run after modifying:
- Response models (`@JsonSerializable`)
- API definitions (`@RestApi`)

```bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes (during development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

> ⚠️ **Never manually edit `.g.dart` files** — they are auto-generated and will be overwritten.

---

## 🧩 State Management

### BLoC Pattern

Every feature follows a consistent BLoC structure:

```
feature/
├── bloc/
│   ├── feature_bloc.dart     # BLoC class (maps events → states)
│   ├── feature_event.dart    # Event definitions
│   └── feature_state.dart    # State definitions
└── view/
    └── feature_view.dart     # UI widget
```

### Example BLoC

```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc(this.cartUseCase) : super(CartInitial()) {
    on<CartFetched>((event, emit) async {
      emit(CartLoading());
      (await cartUseCase.execute(CartUseCaseInput(event.authorization))).fold(
        (failure) => emit(CartFailure(message: failure.message)),
        (response) => emit(CartSuccess(orderModel: response)),
      );
    });
  }
}
```

### State Types

All features follow this state pattern:

| State | Description |
|-------|-------------|
| `Initial` | Default state before any action |
| `Loading` | Request in progress |
| `Success` | Data loaded successfully |
| `Failure` | Error occurred (contains message) |

---

## 🌐 API Layer

### Retrofit Endpoints

API endpoints are defined in `lib/data/network/app_api.dart` using Retrofit annotations:

```dart
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("{storeId}/V1/ozoneapp/homescreen")
  Future<HttpResponse<HomeScreenResponse>> homeScreen(
    @Header("Authorization") String authorization,
    @Path('storeId') String storeId,
    // ... other headers
  );
}
```

### Key Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/integration/customer/token` | Login (get token) |
| `POST` | `/customers` | Register |
| `GET` | `/ozoneapp/splashscreen` | Splash config |
| `GET` | `/ozoneapp/homescreen` | Home screen data |
| `GET` | `/categories` | Category tree |
| `GET` | `/products` | Product listing |
| `GET` | `/carts/mine` | Cart details |
| `POST` | `/carts/mine/items` | Add to cart |
| `GET` | `/customers/me` | User info & addresses |
| `GET` | `/wishlist/items` | Wishlist |
| `GET` | `/orders` | Order history |
| `POST` | `/carts/mine/estimate-shipping-methods` | Shipping rates |
| `GET` | `/carts/mine/payment-methods` | Payment methods |

---

## 🗺 Navigation

Named routing with `onGenerateRoute`. Routes defined in `lib/presentation/resources/routes_manager.dart`:

```dart
class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String mainRoute = "/main";
  static const String productsRoute = "/products";
  static const String productDetailsRoute = "/productDetails";
  static const String cartRoute = "/cart";
  static const String checkOutRoute = "/checkOutRoute";
  static const String paymentRoute = "/paymentRoute";
  // ... 30+ more routes
}
```

Navigate using:
```dart
Navigator.pushNamed(context, Routes.productDetailsRoute, arguments: product);
```

---

## 🌍 Localization

- Built with `easy_localization` package
- Default locale: **Arabic** 🇰🇼
- Supported: Arabic (`ar`) and English (`en`)
- String keys defined in `lib/presentation/resources/strings_manager.dart`
- Translation JSON files in the assets localization path

```dart
// Usage in widgets
Text(AppStrings.login.tr())
```

---

## 🆕 Adding New Features

Follow these 13 steps to add a new feature end-to-end:

### Data Layer
1. Create response model in `data/response/` with `@JsonSerializable()`
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Add API endpoint in `data/network/app_api.dart`
4. Create mapper in `data/mapper/` using `.orEmpty()` / `.orZero()` helpers
5. Add method to `RemoteDataSource`

### Domain Layer
6. Create domain model in `domain/model/` (clean Dart, no annotations)
7. Add method to `Repository` interface
8. Implement in `RepositoryImpl`
9. Create use case extending `BaseUseCase<Input, Output>`

### Presentation Layer
10. Create BLoC (event + state + bloc) in `presentation/feature/bloc/`
11. Create view widget(s) in `presentation/feature/view/`

### Wiring
12. Register use case & BLoC as factories in `app/di.dart`
13. Add route in `presentation/resources/routes_manager.dart`

---

## 📏 Coding Conventions

| Convention | Rule |
|-----------|------|
| **File naming** | `snake_case.dart` |
| **Class naming** | `PascalCase` |
| **BLoC registration** | Factory in GetIt (new instance per screen) |
| **Repository returns** | Always `Either<Failure, T>` |
| **Null safety** | Use `.orEmpty()`, `.orZero()`, `.orBooleanFalse()` in mappers |
| **Responsive sizing** | Use ScreenUtil (`16.sp`, `20.w`, `20.h`) |
| **Generated files** | Never edit `.g.dart` files manually |
| **BLoC disposal** | Always dispose in `StatefulWidget.dispose()` |
| **Folder structure** | `feature/bloc/`, `feature/view/`, `feature/widgets/` |

---

## 📊 Codebase Stats

| Metric | Count |
|--------|-------|
| Total Dart Files | **560** |
| Lines of Code | **~60,395** |
| API Response Models | **40** (+40 generated) |
| Data Mappers | **28** |
| Domain Models | **43** |
| Use Cases | **49** |
| Presentation Modules | **40+** |
| BLoC Components | **50+** |
| Named Routes | **40+** |
| REST API Endpoints | **52+** |
| Reusable Widgets | **14** |

---

## 📄 License

This project is proprietary software. All rights reserved.

---

<p align="center">
  <strong>Prepared by:</strong> Mohammed Elshwehy | Technical Project Manager<br/>
  <em>February 2026</em>
</p>
