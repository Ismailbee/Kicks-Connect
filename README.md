# Kicks-Connect

Multi-version shoe store built with Flutter (Web, Android, iOS) + Firebase.

## Features
- Product grid with filters, detail page, cart and checkout
- Auth (email/social via Firebase Auth)
- Admin dashboard to manage products, orders, inventory
- Payments: Stripe (example) with room for Paystack/Flutterwave
- Dark/Light mode, responsive design

## Quick start (Windows, PowerShell)
1) Install Flutter and enable web + desktop support
	 - https://docs.flutter.dev/get-started/install
	 - After install:
```
flutter doctor ; flutter config --enable-web
```

2) Initialize missing platform folders, then fetch deps
```
flutter create . ; flutter pub get
```

3) Firebase setup
- Create a Firebase project
- Add apps: Web, Android, iOS
- Download and place configs:
	- Web: add the generated `firebaseOptions` to `main.dart` or use `flutterfire configure`
	- Android: `android/app/google-services.json`
	- iOS: `ios/Runner/GoogleService-Info.plist`
- Run `flutterfire configure` to auto-generate options if preferred.

4) Run the app (web)
```
flutter run -d chrome
```

5) Run the app (android emulator)
```
flutter emulators ; flutter emulators --launch <id> ; flutter run -d <deviceId>
```

## Firebase schema
See `firebase/schema.md` for collections, indexes, and security rules draft.

## Payments
- Stripe via `flutter_stripe` package
- Paystack/Flutterwave can be integrated with web views or server functions. Add your chosen provider in `lib/services/payment/` and wire into `CheckoutPage`.

## Build & Deploy (Web)
```
flutter build web
```
Host the `build/web` folder on:
- Firebase Hosting
- Netlify / Vercel / Cloudflare Pages

## Publish (Mobile)
- Android: generate keystore, set `key.properties`, run `flutter build appbundle`, upload AAB to Play Console
- iOS: set signing in Xcode, run `flutter build ipa`, upload via Transporter/App Store Connect

## Project structure
- `lib/` app code
- `lib/ui/pages/` screens (home, products, details, cart, checkout, profile, admin)
- `lib/services/` firebase and payment services
- `lib/domain/` data models
- `firebase/` schema and rules

## Helper scripts (PowerShell)
- Setup Flutter and run app:
```
./scripts/setup_flutter.ps1 -Run
```
- Connect Firebase (choose your project and platforms):
```
./scripts/connect_firebase.ps1 -ProjectId <your-firebase-project-id> -Web -Android
```

## Next steps
- Implement real data flows using `cloud_firestore`
- Add authentication UI and guards for admin
- Integrate a payment provider end-to-end
- Polish visuals to mimic Nike/Adidas layouts
