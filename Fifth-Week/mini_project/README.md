# Week 5 Mini Project - Flutter Structured App

This project demonstrates a clean, well-structured Flutter application with organized folders for models, services, views, utils, assets (images), and resources (data).

## Project Folder Structure

```text
mini_project/
│
├── assets/
│   ├── images/          # Place your PNG, JPG, SVG images here
│   └── data/            # Place JSON, CSV, or text resource files here
│
├── lib/
│   ├── models/          # Data models (e.g., item_model.dart)
│   ├── services/        # API calls and business logic (e.g., api_service.dart)
│   ├── views/           # UI Screens (e.g., home_view.dart)
│   ├── utils/           # Constants and helpers (e.g., constants.dart)
│   └── main.dart        # Entry point of the Flutter application
│
├── pubspec.yaml         # Dependencies and asset declarations
└── README.md            # Documentation and guide
```

---

## How to Create This Mini Project on Your Own (Step-by-Step Guide)

### Step 1: Create a New Flutter Project
Open your terminal (or command prompt) and run:
```bash
flutter create mini_project
```
Navigate into your project folder:
```bash
cd mini_project
```

### Step 2: Set Up Folder Structure inside `lib/`
Create the required subfolders inside the `lib/` directory:
- `lib/models`
- `lib/services`
- `lib/views`
- `lib/utils`

### Step 3: Set Up Assets & Resources
1. Create an `assets/` folder in the project root.
2. Inside `assets/`, create subfolders: `assets/images/` and `assets/data/`.
3. Register your assets in `pubspec.yaml` under the `flutter:` section so Flutter knows to load them:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/data/
```

### Step 4: Write Your Code Files
- **`lib/utils/constants.dart`**: Define app titles, API endpoints, and styling constants.
- **`lib/models/item_model.dart`**: Define data classes with `fromJson` and `toJson` methods.
- **`lib/services/api_service.dart`**: Handle data fetching or mock API responses.
- **`lib/views/home_view.dart`**: Build UI widgets (e.g., `StatefulWidget`, `FutureBuilder`, `ListView.builder`).
- **`lib/main.dart`**: Set up `MaterialApp` and launch your root view.

### Step 5: Run Your App
Connect your device or start an emulator, then run:
```bash
flutter run
```
