# Service Reservation Doctors App  👨‍⚕️ 🚀

## Overview

The Service Reservation App is a mobile application built using Flutter 📱 that allows users to book appointments with service providers (specialists Doctors 🥼 ). This app is designed to streamline the appointment booking process, providing a user-friendly interface for selecting services, specialists, dates, and times. ⏰

## Features

* **Specialist Listing:** Browse a list of specialists, including their names, specializations, and available days. 👨‍⚕️👩‍⚕️
* **Appointment Booking:** Select a specialist, date, and time to book an appointment. 📅
* **User Authentication:**  Secure user authentication for managing appointments. 🔒
* **My Appointments:** View and manage booked appointments. 📆
* **Cancel Appointments:**  Cancel upcoming appointments. ❌
* **Splash Screen:** A visually appealing splash screen. ✨
* **GetX State Management:** App uses GetX for state management. 🧰
* **Firebase Integration:** App uses Firebase as a backend. 🔥

## Setup Instructions

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/Aslmmon/ServiceReservationApp.git
    cd ServiceReservationApp
    ```

2.  **Install Flutter:**
    Ensure you have Flutter installed on your machine. If not, follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install) 🛠️


3.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

4.  **Run the App:**

    ```bash
    flutter run
    ```

## App Architecture Explanation

The app follows a layered architecture, primarily using the GetX framework. Here's a breakdown: 🏗️

* **`main.dart`:** The entry point of the application. Initializes Firebase, sets up GetX controllers, and runs the `GetMaterialApp`. 🚀
* **`data/`:**
    * `data/models`: Contains the data models used in the app (e.g., `Specialist`, `Appointment`). These models define the structure of the data retrieved from Firebase. 🗂️
    * `data/data_sources`:  Implements the data layer, responsible for fetching and manipulating data. Uses Firebase Firestore for database operations. This is where the actual interaction with Firebase occurs. 📦
* **`domain/`:**
    * `domain/repositories`: Defines the abstracted contract between Domain layer and data layer as : AppointmentRepository , SpecialistRepository , UserRepository . 
    * `domain/use_cases`: Defines the business logic of the application. Use cases orchestrate the interaction between repositories and present the data to the presentation layer. For example, `BookAppointmentUseCase`, `GetSpecialistsUseCase`. ⚙️
* **`presentation/`:**
    * `presentation/booking`: Contains the `BookingScreen` and its associated logic, allowing users to select a date and time and confirm their appointment. The `BookingController` manages the state for this screen. 📅
    * `presentation/specialists`: Contains the `SpecialistsScreen` for displaying a list of specialists and navigating to the booking screen. 👨‍⚕️👩‍⚕️
    * `presentation/appointments`: Contains the `MyAppointmentsScreen` for displaying user appointments. 📆
    * `presentation/widgets`: Reusable UI components. 🧩
* **`utils/`:**
    * `utils/appColors`: Defines the color palette used throughout the app. 🎨 -> could also use Theme.context to manage light/dark theme. 
    * `utils/appStrings`: Contains string constants for localization and to avoid hardcoded strings. 📝
    * `utils/appTextStyle`: Defines the text styles used in the app. ✍️
* **`routes/`:**
    * `utils/app_routes`: This file defines the application's navigation routes using the GetX package. It specifies how the app navigates between different screens (e.g., login, register, home) and associates each screen with its corresponding widget and any necessary dependencies
    * `utils/app_navigation`: responsible for handling the app's navigation logic. It determines the initial screen to display based on the user's authentication state (whether they are logged in or not) and provides methods for navigating to different parts of the app

## Key Components and Technologies

* **Flutter:** The primary framework for building cross-platform mobile applications. 💙
* **GetX:** Used for state management, dependency injection, and route management. Controllers (like `BookingController`, `SpecialistsController`) manage the state for specific parts of the UI. 🧰
* **Firebase:**
    * **Firestore:** Used as the database to store specialist information, appointment details, and (potentially) user data. 🔥
    * **Authentication:**  Handles user authentication. 🔑

## Business Requirements Answers:

### Business Requirements Understanding:

The app's primary business goal is to modernize and simplify the appointment booking process. It aims to replace traditional methods like phone calls with a user-friendly mobile platform, enabling users to easily find specialists, view their availability, and schedule appointments. By providing a centralized and accessible system, the app seeks to improve efficiency for both users and service providers, reducing scheduling conflicts and administrative overhead. Ultimately, the app intends to enhance the overall experience of booking services, making it faster, more convenient, and less prone to errors.

### User Experience Thought Process:

One feature that could significantly enhance the booking experience is **interactive availability visualization**. Instead of just showing a list of available times, the app could display a weekly or monthly calendar view where available slots are clearly marked. Users could then quickly identify available days and times at a glance, and by tapping on a slot, immediately initiate the booking process. This visual approach would make the selection process more intuitive and delightful, reducing the cognitive load on the user.



## Known Limitations

* **UI Improvements:** The UI could be further enhanced for a more modern and visually appealing design. 🎨
* **Advanced Features:** The app currently implements the basic booking functionality. The following features could be added: ➕
    * User profiles and account management. 👤
    * Appointment reminders and notifications. 🔔
    * Recurring appointments. 🔁
    * Specialist reviews and ratings. ⭐
    * Payment integration. 💳
    * More robust error handling and user feedback. ⚠️
    * Pagination feature to load large amount of data in the  Specialist list 👤

* **Testing:** More comprehensive unit and integration tests could be added to ensure the app's stability and reliability. 🧪
* **Scalability:** Considerations for handling a large number of users and appointments might need further refinement (e.g., database optimizations, caching). ⬆️
* **Real-time Updates:** The app may not reflect real-time changes in specialist availability if multiple users are booking simultaneously. This could be improved with more sophisticated state management or backend solutions (e.g., WebSockets). ⚡

## App WorkFlow Demo : 

[Watch the App Demo Reel on YouTube](https://www.youtube.com/shorts/HCueeOQJ9nE)

This is a short demo of the Service Reservation App in action. Click the link above to view the reel on YouTube.

[APK downloadable link to test live](https://drive.google.com/file/d/1zPftoKCAe1iBm8aF0BwGv4aUIynl_tSh/view?usp=sharing)


