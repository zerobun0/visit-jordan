# 🇯🇴 Visit Jordan — Flutter Tourism App

A mobile application promoting tourism in Jordan, built with Flutter.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🏺 Tourist Attractions | Petra, Wadi Rum, Dead Sea, Jerash — with photos, history, highlights & location |
| 📸 Photo Gallery | 5 real photos per landmark, swipeable with dot indicators |
| 🗺️ Google Maps | One-tap button opens exact location in Google Maps (no API key needed) |
| 🤖 AI Assistant | Gemini-powered chat assistant for travel tips & route suggestions |
| 🧠 Quiz | Multiple-choice Jordan tourism quiz with sound feedback |
| ⭐ Reviews | Add, edit and delete your own star-rated reviews per attraction |

---

## 📱 Installing the APK (Just want to use the app)

1. Transfer `VisitJordan.apk` to your **Android phone**
2. Open the file on your phone
3. If prompted, go to **Settings → Install unknown apps → Allow**
4. Tap **Install**
5. Open **Visit Jordan** from your home screen

> ⚠️ Requires Android 6.0 or higher.  
> 🤖 For the AI Assistant, you need a free Gemini API key from [aistudio.google.com](https://aistudio.google.com)

---

## 💻 Running the Source Code (For developers)

### Step 1 — Install Flutter

1. Go to [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Choose **Windows**
3. Download the Flutter SDK and extract it (e.g. `C:\flutter`)
4. Add `C:\flutter\bin` to your system **PATH** environment variable
5. Open a terminal and run:
   ```
   flutter doctor
   ```
   Fix any issues it reports before continuing.

### Step 2 — Install Android Studio

1. Download from [developer.android.com/studio](https://developer.android.com/studio)
2. Install with default settings
3. Open Android Studio → **More Actions → SDK Manager**
4. Make sure **Android SDK** is installed
5. Go to **More Actions → Virtual Device Manager → Create Device**
6. Pick **Pixel 7**, select a system image (API 34), and click **Finish**

### Step 3 — Install VS Code (Recommended Editor)

1. Download from [code.visualstudio.com](https://code.visualstudio.com)
2. Install the **Flutter** extension (search in Extensions panel)
3. Install the **Dart** extension

### Step 4 — Open the Project

1. Unzip `VisitJordan_Source.zip` to any folder
2. Open **VS Code** → **File → Open Folder** → select the unzipped folder
3. Open the integrated terminal (**Ctrl + `**)
4. Run:
   ```
   flutter pub get
   ```
   This downloads all dependencies.

### Step 5 — Run the App

**On Emulator:**
```
flutter run
```

**On a real Android phone:**
1. Enable **Developer Options** on your phone (tap Build Number 7 times)
2. Enable **USB Debugging**
3. Connect phone via USB
4. Run:
   ```
   flutter run
   ```

**Build your own APK:**
```
flutter build apk --release
```
The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🔑 Setting up the AI Assistant

1. Go to [aistudio.google.com](https://aistudio.google.com)
2. Sign in with a Google account
3. Click **Get API Key → Create API Key**
4. Copy the key
5. Open the app → tap **AI Assistant** → paste the key when prompted
6. The key is saved on the device — you only need to do this once

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point & theme
├── screens/
│   ├── home_screen.dart         # Main home screen
│   ├── attractions_screen.dart  # List of all attractions
│   ├── attraction_detail_screen.dart  # Detail + gallery + reviews
│   ├── ai_assistant_screen.dart # Gemini AI chat
│   ├── quiz_screen.dart         # Interactive quiz
│   └── api_key_screen.dart      # API key setup
├── models/
│   ├── attraction.dart          # Attraction data model
│   ├── review.dart              # Review data model
│   └── quiz_question.dart       # Quiz question model
├── data/
│   ├── attractions_data.dart    # All attraction content
│   └── quiz_data.dart           # Quiz questions
└── assets/
    └── images/                  # 20 landmark photos (5 per attraction)
```

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `google_fonts` | Poppins font |
| `audioplayers` | Quiz sound effects |
| `url_launcher` | Google Maps deep linking |
| `http` | AI Assistant API calls |

---

## 🎨 Design

- **Primary colour:** `#8B4513` (Saddle Brown)
- **Secondary colour:** `#D4A843` (Golden Sand)
- **Background:** `#FFF8F0` (Warm White)
- **Font:** Poppins
