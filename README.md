TransportApp

A SwiftUI iOS transportation app that uses Firebase Authentication and Firestore to support rider/driver accounts, rider check-ins, driver check-in visibility, and rider location tracking.

Project status: Prototype / early-stage application. The repository contains working architectural pieces, but authentication error handling, authorization, location updates, testing, and several UI/data flows need hardening before production use.

Overview

TransportApp is designed around two user roles:

Rider — creates an account, signs in, views their profile, checks in, and accesses a GPS/map screen.

Driver — signs in, views their profile, and views users recorded as checked in.

Firebase provides the backend identity and user data store:

Firebase Authentication manages email/password accounts.

Cloud Firestore stores user profiles and check-in records.

The current application is primarily a SwiftUI client with Firebase-backed persistence.

Features

Implemented

Driver/rider role selection

Email/password registration

Email/password login

Firebase Authentication session handling

Firestore user profile creation and retrieval

Role-based main navigation

Driver profile

Rider profile

Rider check-in record creation

Driver-facing list of checked-in users

MapKit-based user-location display

Basic reusable button and settings-row components

Unit-test and UI-test targets

Incomplete or needs hardening

Account deletion

Authentication error presentation

Strong server-side role authorization

Continuous location tracking

Production-grade check-in lifecycle

Real-time check-in updates

Automated functional tests

Persistent dark-mode implementation

Image/profile-photo integration

Production security rules and backend validation

Tech Stack

Technology

Purpose

Swift 5

Application language

SwiftUI

User interface

Firebase Authentication

Email/password authentication

Cloud Firestore

User and check-in data

Firebase iOS SDK 11.0.0

Firebase integration

MapKit

Map rendering

Core Location

Location authorization/location updates

XCTest

Unit and UI testing

Xcode project / Swift Package Manager

Build and dependency management

The main application target is configured for iOS 17.5+. The separate Transportation app-extension target is configured for iOS 18.0.

Prerequisites

macOS with Xcode installed

Xcode 16 or newer is recommended for the supplied project configuration

iOS 17.5+ deployment target

An Apple development team/signing configuration

A Firebase project configured for the application

Firebase Authentication with Email/Password enabled

Cloud Firestore enabled

Installation & Setup

1. Clone the repository

git clone https://github.com/marcusj12/TransportApp.git
cd TransportApp

2. Open the Xcode project

Open:

TransportApp.xcodeproj

The project uses Swift Package Manager. Xcode should resolve the Firebase dependencies from the committed Package.resolved file.

3. Configure Firebase

Create or select a Firebase project and register an iOS application using the bundle identifier:

com.TransportApp

Download the Firebase configuration file:

GoogleService-Info.plist

Place it in:

TransportApp/Other/GoogleService-Info.plist

The application initializes Firebase in TransportAppApp.swift with:

FirebaseApp.configure()

4. Enable Firebase Authentication

In Firebase Console:

Open Authentication.

Enable Email/Password.

Configure any additional authentication settings required by the application.

5. Enable Cloud Firestore

Create a Firestore database.

The current application expects these collections:

users/{userId}
checkins/{userId}

A user document currently contains fields equivalent to:

{
  "id": "firebase-user-id",
  "name": "Example User",
  "email": "user@example.com",
  "role": "Rider"
}

A check-in document currently contains:

{
  "checkedIn": true,
  "timestamp": "Firestore Timestamp"
}

6. Configure Firestore Security Rules

Do not rely on the SwiftUI role-selection UI for authorization.

Before production, Firestore rules should enforce:

Users can read/write only the user data they are permitted to access.

Riders can create/update their own check-in state.

Drivers can read the check-in records they are authorized to see.

A rider cannot write another user's check-in document.

A user cannot elevate their own role by modifying their Firestore document.

Example rule design should be created and tested specifically for the application's business requirements rather than copied blindly from this README.

7. Configure Location Permissions

The application target includes the location usage description:

Please Allow us to access your location to locate nearest pickup destination

Verify the corresponding privacy permission in the Xcode target settings and test location behavior on a physical device or with Xcode's simulated location tools.

Usage

Registration flow

Launch the application.

Select Driver or Rider.

Select Create an Account.

Enter name, email, password, and password confirmation.

Submit the registration form.

Firebase creates the authentication account.

The application writes the corresponding user document to Firestore.

Login flow

Select a role.

Enter email and password.

Authenticate with Firebase.

The application retrieves the Firestore user profile.

The stored role determines whether the driver or rider main screen is shown.

Rider flow

The rider receives:

Profile tab

GPS tab

Check-in functionality through the current CheckInView implementation

Driver flow

The driver receives:

Profile tab

Check-In tab

The current driver check-in screen reads checkins where checkedIn == true, then retrieves the corresponding user documents.

Project Structure

Current structure

The supplied repository is organized approximately as follows:

TransportApp/
├── TransportApp.xcodeproj/
├── TransportApp/
│   ├── Core/
│   │   ├── Authentication/
│   │   │   ├── Views/
│   │   │   └── ViewModels/
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

Recommended structure

A cleaner structure would separate application features from infrastructure and eliminate the authentication-centric grouping of unrelated screens:

TransportApp/
├── App/
│   ├── TransportAppApp.swift
│   └── AppRouter.swift
│
├── Core/
│   ├── Models/
│   │   ├── User.swift
│   │   └── CheckIn.swift
│   ├── Services/
│   │   ├── AuthService.swift
│   │   ├── UserService.swift
│   │   └── CheckInService.swift
│   └── Utilities/
│       └── Extensions.swift
│
├── Features/
│   ├── Authentication/
│   │   ├── LoginView.swift
│   │   ├── RegisterView.swift
│   │   ├── RoleSelectionView.swift
│   │   └── AuthViewModel.swift
│   │
│   ├── Driver/
│   │   ├── DriverMainView.swift
│   │   ├── DriverProfileView.swift
│   │   └── DriverCheckInView.swift
│   │
│   └── Rider/
│       ├── RiderMainView.swift
│       ├── RiderProfileView.swift
│       └── RiderGPSView.swift
│
├── Shared/
│   ├── Components/
│   │   ├── TPButton.swift
│   │   ├── HeaderView.swift
│   │   └── SettingsRowView.swift
│   └── Location/
│       └── LocationManager.swift
│
├── Resources/
│   ├── Assets.xcassets
│   └── GoogleService-Info.plist
│
├── Tests/
│   ├── Unit/
│   └── UI/
│
└── README.md

Configuration / Environment Variables

The current project does not use a .env file or environment-variable abstraction.

Firebase configuration is currently supplied through:

GoogleService-Info.plist

The repository snapshot contains Firebase configuration values. Firebase iOS configuration values such as the API key are generally client-side configuration rather than server credentials, but the Firebase project should still have appropriate API-key restrictions and Firestore/Auth security rules.

Never place:

Firebase Admin SDK credentials

service-account private keys

database administrator credentials

signing certificates/private keys

production secrets

inside the iOS application bundle or Git repository.

For a production project, consider maintaining environment-specific Firebase configuration files and selecting them through Xcode build configurations.

Architecture

The current application follows a lightweight MVVM-style organization:

SwiftUI Views
     |
     v
AuthViewViewModel
     |
     +---- Firebase Authentication
     |
     +---- Cloud Firestore
     |
     +---- User / role state

The application entry point is:

TransportApp/Other/TransportAppApp.swift

which creates the shared authentication view model and injects it into:

ContentView

ContentView then routes the user into:

RoleSelectionView
        |
        +---- LoginView
        |
        +---- DriverMainView
        |
        +---- RiderMainView

Testing

The project contains:

TransportAppTests/
TransportAppUITests/

The supplied tests are currently Xcode-generated placeholder tests and do not provide meaningful coverage of authentication, Firestore persistence, role routing, check-in behavior, or location behavior.

Recommended minimum test coverage:

Unit tests

Authentication validation

Registration validation

Role decoding

User model decoding

Check-in state transitions

Authentication error mapping

Integration tests

User creation + Firestore profile creation

Login + profile retrieval

Missing Firestore user handling

Check-in persistence

UI tests

Rider registration

Driver registration

Login

Role routing

Rider check-in

Driver check-in list

Known Technical Debt

The audit of the supplied project identified several important issues:

Authentication methods catch errors internally and do not rethrow them, so the views' catch blocks cannot reliably display Firebase errors.

The login form uses .disabled(formIsValid), which disables the form when the input is valid. This should be inverted.

deleteAccount() is only a placeholder.

Check-in code is embedded directly in a SwiftUI view instead of a service/view-model layer.

The driver check-in screen performs one Firestore user lookup per check-in document, producing an N+1 read pattern.

Check-in access is not role-restricted in the client and must be protected by Firestore security rules.

LocationManager stops location updates after the first update, so it is not a continuous tracking implementation.

GPSView owns a LocationManager as a stored property of a SwiftUI value type, which is fragile for lifecycle/state management.

Several ViewModels are unused or entirely commented out.

BusUser is unused and duplicates the concept represented by User.

Extensions.swift only supports code that has been commented out elsewhere.

HomeView.swift is entirely commented out.

SwiftUIView.swift is an unused Xcode placeholder.

MainViewViewModel, HomeViewViewModel, ProfileViewViewModel, LoginViewViewModel, RegisterViewViewModel, GpsViewViewModel, GPSViewModel, and DriverViewViewModel are unused/dead implementations in the current source.

DriverProfileView and RiderProfileView duplicate most of their UI.

The dark-mode toggle changes local state but does not apply that state to the view hierarchy.

SettingsRowView.tintColor is passed by callers but ignored by the implementation.

ContentView contains the active routing logic while AuthViewViewModel.navigateBasedOnRole() contains a second routing implementation.

CheckInView.swift contains a large commented-out previous implementation that should be removed.

The repository includes macOS .DS_Store files and Xcode user-specific state that should normally be excluded from source control.

The project contains a separate Transportation Authentication Services app-extension target that appears to be an unused Xcode-generated account-authentication-modification template.

Contributing

Create a feature branch.

Keep feature-specific code inside the appropriate feature directory.

Avoid placing Firebase calls directly inside SwiftUI views.

Add tests for new business logic.

Do not commit credentials, secrets, or local Xcode state.

Run unit and UI tests before opening a pull request.

Keep Firestore authorization changes synchronized with application authorization changes.

Example:

git checkout -b feature/check-in-improvements
git add .
git commit -m "Improve rider check-in flow"
git push origin feature/check-in-improvements
