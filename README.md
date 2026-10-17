# Crash Guard — Emergency Services Panel

**Main repository:** [AliHaider151/FYP-Crash-Guard](https://github.com/AliHaider151/FYP-Crash-Guard)

Crash Guard is a Flutter-based operations panel for reviewing accident reports and coordinating emergency response. It provides role-oriented dashboards for accident monitoring, report review, incident history, and staff-user management. Accident records are stored in Cloud Firestore, and the accident verification dialog listens for live updates so AI-generated results appear as they are written.

## Features

- **Today's accidents:** Monitor current-day reports and update their response status.
- **AI verification details:** Review the verdict, confidence, severity, incident types, detected hazards, reasoning, recommended action, and visual evidence.
- **Live verification updates:** Keep the verification dialog open while new data arrives from Firestore.
- **Incident media and location:** Open the recorded video and view the reported coordinates in Maps.
- **Accident logs:** Browse reports for a selected date range.
- **Reported accidents:** Review accidents marked as resolved.
- **User management:** View and manage staff accounts according to the current role-based interface.
- **Notifications:** Receive foreground Firebase Cloud Messaging notifications.

## Technology

- Flutter and Dart
- Firebase Core and Cloud Firestore
- Firebase Cloud Messaging
- Provider for application state
- GoRouter for navigation
- GetStorage for local session data

## Requirements

- Flutter SDK with Dart **3.9.2 or later**
- A Firebase project configured for the platform you intend to run
- A browser for running the web application

## Getting started

1. Clone the repository and enter the project directory:

   ```bash
   git clone https://github.com/AliHaider151/FYP-Crash-Guard.git
   cd FYP-Crash-Guard
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase for your development project and supported platforms. Ensure the generated platform configuration is available to the app through `lib/firebase_options.dart`. Keep private keys and service-account credentials out of source control.

4. Run the application in a browser:

   ```bash
   flutter run -d chrome
   ```

   To see available Flutter run targets:

   ```bash
   flutter devices
   ```

## Development checks

Run the automated tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

Format Dart source files:

```bash
dart format lib test
```

## Firestore data

The application reads accident records from the `accidents` collection. Accident documents use the following fields:

| Field | Description |
| --- | --- |
| `video_url` | URL of the incident recording |
| `latitude`, `longitude` | Reported incident coordinates |
| `address` | Human-readable incident location |
| `confidence` | Detection confidence |
| `severity` | Accident severity |
| `status` | Current response status |
| `timestamp` | Report timestamp |
| `verification` | Optional AI verification result |

The optional `verification` map can contain `verdict`, `confidence`, `severity`, `incident_types`, `hazards_detected`, `reasoning_summary`, `recommended_action`, `requires_more_frames`, `alternative_explanations`, and `visual_evidence`. Missing values are shown as processing in the panel; empty lists are shown as completed results with no items.

The `users` collection supplies staff account details used by the user-management and role-oriented interface. Configure Firebase access rules for your deployment; hiding a screen in the client is not an authorization boundary.

## Project structure

```text
lib/
  constants/     App configuration, routes, colors, and theme
  models/        Accident and user data models
  providers/     ChangeNotifier-based application state
  repository/    Firestore data access
  services/      Local storage, date/time, and notifications
  views/
    pages/       Accident dashboard, logs, reports, login, and users
    widgets/     Shared interface components
test/            Flutter widget and unit tests
assets/          Fonts, icons, and images
```

## Security and deployment

Use a dedicated Firebase project for each environment and apply least-privilege Firestore Security Rules before deployment. Do not commit credentials, private keys, or production data. Review authentication, account storage, notification permissions, and platform-specific Firebase configuration as part of the production release process.
