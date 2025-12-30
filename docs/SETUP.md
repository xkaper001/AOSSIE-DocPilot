# Setup Guide 🚀

Follow these steps to set up and run the app:

## Prerequisites 🛠️

1. Install [Flutter](https://flutter.dev/docs/get-started/install) on your system. 📥
2. Ensure you have the following installed:
   - Dart SDK (comes with Flutter) 🎯
   - Android Studio or Xcode (for mobile development) 📱
   - A device emulator or a physical device for testing 🖥️
3. Verify your Flutter installation by running:
   ```bash
   flutter doctor
   ```
   ✅ This will check if everything is set up correctly.

## Installation 📂

1. Clone the repository: 🐙
   ```bash
   git clone https://github.com/AOSSIE/docpilot.git
   cd docpilot
   ```
2. Fetch the dependencies: 📦
   ```bash
   flutter pub get
   ```

## Running the App ▶️

1. Generate required files: 🛠️
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   ✅ This command generates necessary files for the app to run properly.
2. Connect your device or start an emulator. 🔌
3. Run the app using the following command: 🏃
   ```bash
   flutter run
   ```

- For troubleshooting, refer to the [Flutter documentation](https://flutter.dev/docs). 📖
