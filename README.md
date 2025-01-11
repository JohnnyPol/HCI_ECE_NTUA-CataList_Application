# CataList - Task Management Application

## Table of Contents
- [CataList - Task Management Application](#catalist---task-management-application)
  - [Table of Contents](#table-of-contents)
  - [Contributors](#contributors)
  - [Introduction](#introduction)
  - [Features](#features)
  - [Installation and Setup](#installation-and-setup)
    - [Prerequisites](#prerequisites)
    - [Steps](#steps)
  - [Usage](#usage)
    - [Running the App](#running-the-app)
    - [Preloaded Data](#preloaded-data)
    - [Screens](#screens)
  - [Requirements](#requirements)
---

## Contributors

- [Giannis Polychronopoulos](https://github.com/JohnnyPol)
- [Sofia Savva](https://github.com/el21189)
- [Nikos Pantazopoulos](https://github.com/Nickp03)


---
## Introduction
**CataList** is a Flutter-based task management application designed to help users organize their daily and long-term goals efficiently. The app includes features such as task tracking, photo management.

---

## Features
- **Task Management**: Add, edit, delete, and categorize tasks as daily or challenges.
- **Photo Storage**: Capture and save photos, grouped by user and timestamp.
- **Calendar View**: View and manage tasks from any selected day using an interactive calendar interface.

- **Navigation**: Intuitive navigation between screens using gestures and buttons.
- **Data Persistence**: Local SQLite database for user authentication, task storage, and photo management.
- **Responsive Design**: Optimized for various screen sizes and orientations.
- **StatefulWidgets**: Smooth data handling and UI updates.
- **Dummy Data**: Preloaded user, tasks, and photos for demonstration purposes.

---

## Installation and Setup

### Prerequisites
1. **Flutter SDK**: Install the latest version of the [Flutter SDK](https://flutter.dev/docs/get-started/install).
2. **Android Studio** or **VS Code**: Set up your preferred IDE with Flutter plugins.
3. **Android Device or Emulator**: Ensure an emulator or physical device is set up for testing.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/JohnnyPol/catalist.git
   cd catalist
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application
   ```
   flutter run
   ```

## Usage

### Running the App
1. Launch the app on your device/emulator.
2. Log in as the preloaded "anonymous" user or create a new account.
3. Navigate through the home screen, calendar, recap, and task views.
4. Add tasks, attach photos, and explore other features.

### Preloaded Data
- **Username**: `anonymous`
- **Password**: `testing`

### Screens
- **Home**: Overview of daily tasks and challenges.
- **Search**: Search through tasks and photos.
- **Calendar**: View tasks by date.
- **Recap**: Weekly and monthly task/photo summaries.
- **Profile**: Manage user information and photos.

---

## Requirements
- **Flutter SDK**: Version `X.X.X` or higher.
- **Android SDK**: Version `XX` or higher (supports Google API services).
- **Dart**: Version `X.X.X` or higher.

---
