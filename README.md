# CineQuest - Movie Ticket Booking App - Clean Architecture & BLoC (Old version)

## Overview

(New version): [CineQuest - Movie Ticket Booking App (New version)](https://github.com/NguyenKhaiHoan/hnk_fullstack_cinequest_movie_booking_app)

This is a **Movie Ticket Booking** application designed with **Clean Architecture** principles and uses **BLoC** (Business Logic Component) for state management. The app allows users to browse movies, view details, and book tickets for their favorite movies at local cinemas. The project follows a structured and modular approach to ensure scalability, testability, and maintainability.

The app is built using **Flutter** and integrates multiple packages like **Dio**, **Retrofit** for API handling, **Dartz** for error handling, **SQLite** for local data storage, and **Get_it** for dependency injection. The architecture ensures a separation of concerns, making it easier to maintain and extend the app's functionality in the future.

---

## Features

### Implemented Features:
- **Authentication & Account Setup**: User login, registration, and logout functionalities using **Firebase**. User data is stored in **FireStore** after account setup is completed.
- **Now Playing Movies**: Browse a list of movies currently playing in theaters from TheMovieDB API.
- **Popular Movies**: View a list of popular movies from TheMovieDB API.
- **Favorite Movies**: Mark and manage your favorite movies locally using **SQLite**.
  
### Upcoming Features:
- **Forgot Password**: Complete the authentication flow with password recovery.
- **Movie Details**: See detailed information about each movie, including genre, runtime, and user ratings.
- **Search Movies**: Search for your favorite movies in the database.
- **Booking History**: Users can view their past ticket bookings.
- **Payment Integration**: Integrate a payment gateway for secure bookings.
- **Push Notifications**: Notify users of upcoming movies, new releases, and special offers.
- **Cinema Locations and Seat Selection**: Implement seat maps for cinemas and allow users to choose seats.
- **Multi-language Support**: Support for multiple languages to enhance user experience globally.
  
---

## Demo Screenshots
*Currently Updating...*

---

## References

### UI Inspiration
- [Behance - CineQuest](https://www.behance.net/gallery/173303277/CineQuest?tracking_source=search_projects_appreciations|movie+ui+mobile+app&l=510)

### Project
- [Flutter project boilerplate that adheres to the principles of Clean Architecture](https://github.com/V0-MVP/flutter-bloc-clean-architecture-boilerplate)

### Articles
- [Building Maintainable Flutter Apps with Clean Architecture](https://medium.com/@mvpcatalyst/building-maintainable-flutter-apps-with-clean-architecture-991305ec1744)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
