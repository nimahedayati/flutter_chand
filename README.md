# Flutter Chand?!

A Flutter application for tracking currency rates and conversions. Built with modern Flutter practices and a clean architecture approach.

## Features

- Real-time currency rate tracking
- Dark theme UI with Material Design 3
- Clean architecture using BLoC pattern
- Responsive design for all devices

## Project Structure

```
lib/
├── bloc/         # State management using BLoC pattern
├── models/       # Data models
├── repositories/ # Data layer and API interactions
├── screens/      # UI screens
└── main.dart     # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.2.3)

### Installation

1. Clone the repository
```bash
git clone [your-repository-url]
```

2. Navigate to the project directory
```bash
cd flutter_chand
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Backend Repository

This application is connected to a backend service. You can find the backend repository at:
[Backend Repository URL]

## Dependencies

- `flutter_bloc: ^9.1.0` - State management
- `dio: ^5.8.0+1` - HTTP client
- `equatable: ^2.0.7` - Value equality
- `google_fonts: ^6.2.1` - Custom fonts

## Development

This project follows clean architecture principles and uses the BLoC pattern for state management. The code is organized into the following layers:

- **Presentation Layer**: Contains UI components and BLoC logic
- **Domain Layer**: Contains business logic and models
- **Data Layer**: Handles data operations and API interactions

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
