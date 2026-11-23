# Md Jahangir Alam — Developer Portfolio

**Flutter Developer · AI Automation Specialist**

A personal portfolio built with Flutter Web to present my development skills, services, selected projects, and contact information.

## Live websites

- **Primary website:** [myportfolio-f6cfb.web.app](https://myportfolio-f6cfb.web.app/)
- **GitHub Pages mirror:** [mdjahangir424.github.io/myportfolio](https://mdjahangir424.github.io/myportfolio/)

## Overview

This portfolio highlights my work in Flutter application development and AI-powered workflow automation. It is designed to provide a responsive browsing experience across desktop, tablet, and mobile screens.

## Features

- Responsive portfolio layout
- Light and dark themes, with the selected theme saved locally
- About, skills, services, projects, and contact sections
- Project previews and links to source repositories
- Flutter Web deployment targets for Firebase Hosting and GitHub Pages
- Accessibility semantics support for the web

## Technology

- **Framework:** Flutter
- **Language:** Dart
- **Routing:** go_router
- **Local preferences:** shared_preferences
- **UI and assets:** Material, Google Fonts, flutter_svg
- **External links:** url_launcher
- **Hosting:** Firebase Hosting and GitHub Pages
- **Automation:** GitHub Actions

## Getting started

### Requirements

- Flutter SDK compatible with the Dart SDK constraint in `pubspec.yaml` (Dart `>=3.4.0 <4.0.0`)
- Google Chrome, if you want to run the web app locally

### Run locally

```bash
git clone https://github.com/mdjahangir424/myportfolio.git
cd myportfolio
flutter pub get
flutter run -d chrome
```

### Validate the project

```bash
flutter analyze
flutter test
```

### Build for web

For the primary Firebase Hosting deployment (root path):

```bash
flutter build web --release --base-href /
```

For the GitHub Pages project site (repository subpath):

```bash
flutter build web --release --base-href /myportfolio/
```

## Repository layout

```text
lib/
  app/        # Application setup and configuration
  data/       # Portfolio data
  models/     # Data models
  screens/    # Screen-level UI
  utils/      # Shared utilities
  widgets/    # Reusable UI components

assets/
  images/
  icons/

web/          # Flutter Web entry point and web assets
.github/      # GitHub Actions workflows
```

## Deployment

Firebase Hosting is the primary website, while GitHub Pages serves as a secondary mirror. Deployment automation is maintained in the repository's GitHub Actions workflows.

## Contact

- **Portfolio:** [myportfolio-f6cfb.web.app](https://myportfolio-f6cfb.web.app/)
- **GitHub:** [@mdjahangir424](https://github.com/mdjahangir424)
- **Repository:** [github.com/mdjahangir424/myportfolio](https://github.com/mdjahangir424/myportfolio)

---

© 2026 Md Jahangir Alam. Built with Flutter.
