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
    - [Changes from Prototype](#changes-from-prototype)
  - [Requirements](#requirements)
  - [Demo Video](#demo-video)
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
- **Search Functionality**: Dynamically search tasks by name or description using SQL **LIKE** queries for efficient filtering.
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
   git clone https://github.com/JohnnyPol/HCI_ECE_NTUA-CataList_Application.git
   cd HCI_ECE_NTUA-CataList_Application
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
- **Photos**: Loaded jpg photos from the `assets/images` folder

### Screens
- **Home**: Overview of daily tasks and challenges.
- **Search**: Search through tasks and photos.
- **Calendar**: View tasks by date.
- **Recap**: Weekly and monthly task/photo summaries.
- **Profile**: Manage user information and photos.

### Changes from Prototype
1. Added photo storage functionality for weekly/monthly recaps.
2. Style of Add Task button in the navigation bar.
3. Added "delete account", "delete photos", and "logout" functionalities in the profile page.


![Home Search Add Task Page](/assets/screenshots/home_search_addTask.png)
![Calendar Recap Profile Page](/assets/screenshots/recap_calendar_profile.png)


## Requirements
- **Flutter SDK**: Version `3.27.1` or higher.
- **Android SDK**: Version `35` or higher.
  - **Minimum SDK Version**: 21 (Android 5.0)
  - **Target SDK Version**: 35 (Android 13)
  - **Compile SDK Version**: 35 (Android 13)
- **Dart**: Version `3.6.0` or higher.
  
---

## Demo Video
Watch the app in action: [CataList Demo](assets/media/HCI_Application_Presentation.mp4)
