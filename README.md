# Manga AR Experience

Manga AR Experience is a Flutter-based mobile application that brings manga panels to life through Augmented Reality. By integrating the Unity engine with Vuforia, this app allows users to scan physical manga pages and view associated AR content, creating an immersive and interactive reading experience.

## Features

- **Manga Series Carousel:** Browse through a selection of available manga series on the home screen.
- **Volume Selection:** Choose a specific manga volume to explore.
- **Augmented Reality:** Scan designated manga panels to trigger AR effects and animations.
- **Unity Integration:** Seamlessly transitions from the Flutter UI to a Unity-powered AR view.
- **Optimized Loading:** Unity is pre-loaded in the background to ensure a smooth and fast transition to the AR experience.

## Technologies Used

- **Frontend:** [Flutter](https://flutter.dev/)
- **AR Engine:** [Unity](https://unity.com/) with [Vuforia](https://developer.vuforia.com/)
- **State Management:** `StatefulWidget` and `StatelessWidget`
- **UI Packages:**
  - [carousel_slider](https://pub.dev/packages/carousel_slider) for the home screen UI.
  - [flutter_unity_widget](https://pub.dev/packages/flutter_unity_widget) to embed Unity within a Flutter app.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version >=2.12.0 <4.0.0)
- [Unity Hub](https://unity.com/download) with a compatible Unity version installed.
- An IDE such as [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter plugin.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/manga-ar-experience.git
    cd manga-ar-experience
    ```

2.  **Set up the Unity Project:**
    - Open the `unity/MangaAR` project in Unity Hub.
    - Ensure you have the Vuforia Engine AR package installed via the Package Manager.
    - Build the Unity project for Android and/or iOS. This will generate the necessary files that Flutter will use. Follow the official `flutter_unity_widget` documentation for detailed steps on exporting the project.

3.  **Run the Flutter app:**
    ```sh
    flutter pub get
    flutter run
    ```

## Project Structure

The project is organized into a Flutter application and an embedded Unity project.

```
.
├── android/            # Android native project
├── assets/             # Images and fonts for the Flutter app
├── ios/                # iOS native project
├── lib/                # Main Flutter application source code
│   ├── data/           # Data source files (e.g., manga lists)
│   ├── models/         # Dart data models (e.g., MangaSeries, MangaVolume)
│   ├── views/          # UI screens/widgets
│   └── main.dart       # App entry point
├── test/               # Flutter tests
├── unity/
│   └── MangaAR/        # The embedded Unity project
└── pubspec.yaml        # Flutter dependencies and project configuration
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.