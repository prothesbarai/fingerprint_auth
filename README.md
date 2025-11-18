
# 🔐 Fingerprint Auth

Add **Fingerprint Login** to your Flutter app — fast, secure, and easy.

---

## 🚀 Features

- Biometric authentication using fingerprint (Android & iOS)
- Easy integration with minimal setup
- Secure: uses native device biometric APIs
- Cross‑platform: works on both **Android** and **iOS**
- Example login flow + fallback (e.g. PIN)

---

## 🧱 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/prothesbarai/fingerprint_auth.git
   cd fingerprint_auth
   ```  
2. **Install dependencies**
   ```bash
   flutter pub get
   ```  
3. **Run on your device/simulator**
   ```bash
   flutter run
   ```  
4. **Try it out**
    - On a real device with fingerprint sensor: tap the fingerprint login button
    - On simulator: you may need to simulate biometrics (depends on your emulator)

---

## 📷 Screenshots

| Before Auth                      | After Auth |
<table>
  <tr>
    <td><img src="asstes/img1.jpeg" width="54%"/></td>
    <td><img src="asstes/img2.jpeg" width="54%"/></td>
  </tr>
</table>
---

## 🛠️ How It Works

1. The app uses the **AndroidX Biometric API** (or equivalent on iOS) to request biometric authentication.
2. When user taps “Login with Fingerprint”, it triggers the biometric prompt.
3. On success, the user is “logged in” (or you can call any callback).
4. On failure or cancel, you can optionally fallback to PIN/password.

---

## 📁 Project Structure

\`\`\`
fingerprint_auth/
├── android/             # Android specific code  
├── ios/                 # iOS specific code  
├── lib/                 # Dart code  
│   ├── main.dart  
│   └── auth/            # Authentication-related logic  
├── test/                # Unit / widget tests  
├── assets/              # Images, icons, etc.  
└── pubspec.yaml
\`\`\`

---

## ✅ Prerequisites

- Flutter SDK installed
- A **physical device** or emulator/simulator with biometric support
- For Android: Android API level that supports biometrics
- For iOS: a device/simulator with Touch ID / Face ID

---

## 🔧 Usage

1. Import the auth module in your Flutter app.
2. Call the fingerprint prompt where needed, e.g.:

   ```dart
   bool didAuthenticate = await AuthService.authenticateWithBiometrics();
   if (didAuthenticate) {
     // Navigate to the protected area
   } else {
     // Show PIN / password fallback
   }
   ```


## 🤝 Contributing

Contributions are very welcome! Feel free to:

- Open issues for bugs or feature requests
- Fork the repo and submit pull requests
- Add tests, improve documentation, or suggest improvements

---

## 📝 License

This project is open-source. Use it freely, improve it, and share it.

---

## 💬 Contact

If you have any questions or want to collaborate, reach out to **Prothes Barai** ([@prothesbarai](https://github.com/prothesbarai)).

---

