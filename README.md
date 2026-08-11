# TransportApp

A SwiftUI iOS transportation app with rider and driver accounts, backed by Firebase Authentication and Cloud Firestore. Riders can register, check in, and view a map screen; drivers can view who's currently checked in.

> **Status: Prototype / early-stage.** The core architecture works, but authentication error handling, authorization, location tracking, testing, and several data flows need hardening before production. See [Known Issues](#known-issues).

## Overview

The app is built around two roles:

- **Rider** — creates an account, signs in, views their profile, checks in, and accesses a GPS/map screen.
- **Driver** — signs in, views their profile, and sees the list of currently checked-in riders.

Firebase provides the backend: **Authentication** manages email/password accounts, and **Cloud Firestore** stores user profiles and check-in records. The app itself is a SwiftUI client following a lightweight MVVM structure.

## Features

**Working**

- Driver/rider role selection
- Email/password registration and login
- Firebase Authentication session handling
- Firestore user profile creation and retrieval
- Role-based navigation (driver vs. rider main screens)
- Rider check-in record creation
- Driver-facing list of checked-in users
- MapKit user-location display
- Reusable button and settings-row components
- Unit- and UI-test targets (scaffolding only)

**Not yet complete**

- Account deletion (placeholder only)
- Authentication error presentation
- Server-side role authorization
- Continuous location tracking
- Real-time check-in updates
- Meaningful automated tests
- Persistent dark mode
- Profile-photo support
- Production Firestore security rules

## Tech Stack

| Technology | Purpose |
|---|---|
| Swift 5 | Application language |
| SwiftUI | User interface |
| Firebase Authentication | Email/password auth |
| Cloud Firestore | User and check-in data |
| Firebase iOS SDK 11.0.0 | Firebase integration |
| MapKit | Map rendering |
| Core Location | Location authorization and updates |
| XCTest | Unit and UI testing |
| Swift Package Manager | Dependency management |

Main target: iOS 17.5+. The separate `Transportation` app-extension target is configured for iOS 18.0.

## Prerequisites

- macOS with Xcode 16 or newer
- An Apple development team / signing configuration
- A Firebase project with Email/Password auth and Cloud Firestore enabled

## Installation & Setup

**1. Clone and open**

```bash
git clone https://github.com/marcusj12/TransportApp.git
cd TransportApp
open TransportApp.xcodeproj
```

Xcode resolves Firebase dependencies from the committed `Package.resolved` file.

**2. Configure Firebase**

Register an iOS app in your Firebase project using the bundle identifier `com.TransportApp`, download `GoogleService-Info.plist`, and place it at:

```
TransportApp/Other/GoogleService-Info.plist
```

Firebase is initialized in `TransportAppApp.swift` via `FirebaseApp.configure()`.

**3. Enable Firebase services**

- In **Authentication**, enable the Email/Password provider.
- In **Firestore**, create a database. The app expects two collections:

```
users/{userId}
checkins/{userId}
```

Example documents:

```jsonc
// users/{userId}
{
  "id": "firebase-user-id",
  "name": "Example User",
  "email": "user@example.com",
  "role": "Rider"
}

// checkins/{userId}
{
  "checkedIn": true,
  "timestamp": "Firestore Timestamp"
}
```

**4. Configure security rules**

Do **not** rely on the role-selection UI for authorization. Before production, Firestore rules should enforce that:

- Users can read/write only the data they're permitted to access.
- Riders can create/update only their own check-in state.
- Drivers can read only the check-in records they're authorized to see.
- A user cannot elevate their own role by editing their Firestore document.

Design and test rules against your actual business requirements rather than copying a generic example.

**5. Configure location permissions**

The target includes a location usage description ("Please allow us to access your location to locate nearest pickup destination"). Verify the privacy permission in target settings and test on a physical device or with Xcode's simulated locations.

## Usage

**Registration** — Launch the app → select Driver or Rider → *Create an Account* → enter name, email, and password → submit. Firebase creates the auth account and the app writes the user document to Firestore.

**Login** — Select a role → enter email and password → authenticate. The app retrieves the Firestore profile, and the stored role determines whether the driver or rider main screen is shown.

**Rider** — Profile tab, GPS tab, and check-in via `CheckInView`.

**Driver** — Profile tab and Check-In tab. The driver screen reads `checkins` where `checkedIn == true` and looks up the matching user documents.

## Architecture

```
SwiftUI Views
     │
     ▼
AuthViewViewModel ──► Firebase Authentication
                 ──► Cloud Firestore
                 ──► User / role state
```

Entry point `TransportAppApp.swift` creates the shared auth view model and injects it into `ContentView`, which routes through `RoleSelectionView` to `LoginView`, `DriverMainView`, or `RiderMainView`.

## Project Structure

Current layout:

```
TransportApp/
├── TransportApp.xcodeproj/
├── TransportApp/
│   ├── Core/
│   │   ├── Authentication/ (Views, ViewModels)
│   │   ├── Models/
│   │   ├── Profile/
│   │   └── Root/
│   ├── Components/
│   ├── Managers/
│   ├── Other/
│   └── Preview Content/
├── TransportAppTests/
├── TransportAppUITests/
└── Transportation/
```

A cleaner structure would separate features from infrastructure and drop the authentication-centric grouping of unrelated screens:

```
TransportApp/
├── App/                  # TransportAppApp.swift, AppRouter.swift
├── Core/
│   ├── Models/           # User.swift, CheckIn.swift
│   ├── Services/         # AuthService, UserService, CheckInService
│   └── Utilities/
├── Features/
│   ├── Authentication/   # Login, Register, RoleSelection, AuthViewModel
│   ├── Driver/           # DriverMainView, DriverProfileView, DriverCheckInView
│   └── Rider/            # RiderMainView, RiderProfileView, RiderGPSView
├── Shared/
│   ├── Components/       # TPButton, HeaderView, SettingsRowView
│   └── Location/         # LocationManager
├── Resources/            # Assets.xcassets, GoogleService-Info.plist
├── Tests/                # Unit, UI
└── README.md
```

## Configuration

The project uses no `.env` file; Firebase config comes from `GoogleService-Info.plist`. Firebase iOS values (including the API key) are client-side configuration rather than server secrets, but you should still apply API-key restrictions and proper Auth/Firestore rules.

**Never** commit Firebase Admin SDK credentials, service-account keys, database admin credentials, signing certificates/private keys, or other production secrets to the app bundle or repository. For production, consider environment-specific config files selected via Xcode build configurations.

## Testing

The `TransportAppTests` and `TransportAppUITests` targets currently contain only Xcode-generated placeholders with no meaningful coverage. Recommended additions:

- **Unit** — auth/registration validation, role decoding, user model decoding, check-in state transitions, error mapping.
- **Integration** — user creation + profile write, login + profile retrieval, missing-user handling, check-in persistence.
- **UI** — rider/driver registration, login, role routing, rider check-in, driver check-in list.

## Known Issues

Audit of the current source surfaced the following:

**Bugs**

- Auth methods catch errors internally without rethrowing, so view `catch` blocks can't display Firebase errors.
- The login form uses `.disabled(formIsValid)`, disabling the form when input *is* valid — the condition is inverted.
- `deleteAccount()` is a placeholder.
- `LocationManager` stops updates after the first fix, so it isn't continuous tracking.
- The dark-mode toggle updates local state but doesn't apply it to the view hierarchy.
- `SettingsRowView.tintColor` is passed by callers but ignored.

**Architecture**

- Check-in logic lives directly in a SwiftUI view instead of a service/view-model layer.
- The driver check-in screen does one Firestore lookup per check-in document (N+1 read pattern).
- Check-in access isn't role-restricted client-side and must be protected by Firestore rules.
- `GPSView` owns a `LocationManager` as a stored property of a value type, which is fragile for lifecycle management.
- Routing is duplicated between `ContentView` and `AuthViewViewModel.navigateBasedOnRole()`.
- `DriverProfileView` and `RiderProfileView` duplicate most of their UI.

**Dead code / cleanup**

- Unused/commented view models: `MainViewViewModel`, `HomeViewViewModel`, `ProfileViewViewModel`, `LoginViewViewModel`, `RegisterViewViewModel`, `GpsViewViewModel`, `GPSViewModel`, `DriverViewViewModel`.
- `BusUser` duplicates `User`; `HomeView.swift` and `SwiftUIView.swift` are commented-out/placeholder files; `Extensions.swift` only supports commented-out code; `CheckInView.swift` contains a large commented-out prior implementation.
- Committed `.DS_Store` files and Xcode user state should be excluded from source control.
- The `Transportation` app-extension target appears to be an unused Xcode-generated authentication template.

## Contributing

- Create a feature branch and keep feature-specific code in the appropriate feature directory.
- Avoid calling Firebase directly inside SwiftUI views — use a service/view-model layer.
- Add tests for new business logic, and run unit and UI tests before opening a PR.
- Keep Firestore authorization rules in sync with application authorization changes.
- Don't commit credentials, secrets, or local Xcode state.

```bash
git checkout -b feature/check-in-improvements
git add .
git commit -m "Improve rider check-in flow"
git push origin feature/check-in-improvements
```
