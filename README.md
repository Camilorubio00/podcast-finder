# 🎧 PodcastFinder - Base Project

Welcome! This is the base project for the mobile developer coding assessment. Your task will be to extend this project by implementing podcast search and detail functionality.

## 📋 Prerequisites

Before starting, make sure you have:

- **Flutter SDK**: Version 3.24.0 or higher
  - Check with: `flutter --version`
  - Install from: https://flutter.dev/docs/get-started/install

- **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter plugins

- **Devices**: 
  - **Android**: Android Studio with emulator, or physical device
  - **iOS**: Xcode with simulator (Mac only), or physical device

## 🚀 Getting Started

### 1. Download and upload the base project to a git repository

Download the project podcast\_finder.zip and upload the base project to Gitlab/Github.

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate code for models

This project uses `json_serializable` for model serialization. Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Note**: You'll need to run this command again whenever you create or modify model files with `@JsonSerializable()` annotations.

### 4. Run the app

```bash
flutter run
```

**Or use your IDE's run button** 

The app should now be running and showing a list of 3 hardcoded podcasts!

## 🏗️ Project Architecture

This project uses **Feature-First Architecture** with clean separation of concerns:
```
lib/
├── core/               # Shared code across features
│   ├── network/       # HTTP client, API config, error handling
│   ├── router/        # Navigation configuration (go_router)
│   ├── theme/         # App theming and colors
│   └── utils/         # Utility classes (Debouncer, formatters)
├── features/          # Features organized by domain
│   └── home/
│       ├── data/          # Data layer
│       │   └── models/    # Data models with JSON serialization
│       ├── domain/        # Business logic (optional for this project)
│       └── presentation/  # UI layer
│           ├── screens/   # Full-screen widgets
│           └── widgets/   # Reusable UI components
└── main.dart
```

### Architecture Principles

Each feature follows a layered approach:

1. **Data Layer**: API calls, data models, repository implementations
2. **Domain Layer**: Business logic and contracts (can be skipped for simple features)
3. **Presentation Layer**: UI components and state management

### Key Technologies

- **State Management**: Riverpod (Provider-based, no code generation)
- **Networking**: Dio with custom interceptors
- **Serialization**: json_serializable for models
- **Routing**: go_router for declarative navigation
- **UI**: Material 3 with custom theme

## 📝 Your Tasks

You have two main tickets to implement. See the **TICKETS.md** file for detailed requirements.

### Quick Overview:

**Ticket 1**: Implement podcast search functionality  
**Ticket 2**: Add podcast detail screen with episodes

### Design References

- See `designs/search_screen.md` for search UI specifications
- See `designs/detail_screen.md` for detail screen UI specifications

## 🛠️ Development Guidelines

### Code Generation

After creating or modifying model files with `@JsonSerializable()`:
```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates the `.g.dart` files needed for JSON serialization.

### State Management with Riverpod

Example of creating a provider:
```dart
// Simple provider
final myDataProvider = Provider<MyData>((ref) {
  return MyData();
});

// StateNotifier for complex state
final myNotifierProvider = StateNotifierProvider<MyNotifier, MyState>((ref) {
  return MyNotifier();
});
```

Example of consuming a provider:
```dart
// In a ConsumerWidget
@override
Widget build(BuildContext context, WidgetRef ref) {
  final data = ref.watch(myDataProvider);
  return Text(data.toString());
}
```

### Creating Models

Example of a model with json_serializable:
```dart
import 'package:json_annotation/json_annotation.dart';

part 'my_model.g.dart';

@JsonSerializable()
class MyModel {
  final String id;
  final String name;
  
  const MyModel({required this.id, required this.name});
  
  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
```

### API Calls

The project includes a **MockInterceptor** that simulates API responses. This means:
- ✅ You don't need a real API key
- ✅ The app works offline
- ✅ Responses are consistent and predictable

When you make API calls using the configured Dio client from `dioProvider`, you'll get mock data automatically.

### Naming Conventions

- **Providers**: `searchPodcastsProvider`, `podcastDetailProvider`
- **Screens**: `SearchScreen`, `PodcastDetailScreen`
- **Widgets**: `PodcastCard`, `EpisodeListTile`
- **Models**: `PodcastModel`, `EpisodeModel`
- **Notifiers**: `SearchNotifier`, `DetailNotifier`

## 🧪 Testing

Run tests with:
```bash
flutter test
```

The project includes an example test in `test/example_test.dart`. You should add tests for your implementations, especially:
- StateNotifier/provider logic
- Model serialization/deserialization
- Widget tests for custom components

Example test structure:
```dart
void main() {
  group('MyNotifier', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      final notifier = container.read(myNotifierProvider.notifier);
      expect(notifier.state, isA<InitialState>());
    });
  });
}
```

## 📤 Submission

When you're done:

1. **Commit frequently** with descriptive messages
   - ✅ Good: "Add search functionality with debouncing"
   - ❌ Bad: "Update files" or "WIP"

2. **Open a Pull Request** with:
   - A clear description of what you implemented
   - Checklist of acceptance criteria you completed
   - Any trade-offs or decisions you made
   - (Optional) Notes on AI assistance you used

3. **Include this in your PR description:**
```markdown
## Implementation Summary

- [ ] Ticket 1: Search functionality
- [ ] Ticket 2: Detail screen

## Technical Decisions

[Explain key decisions you made]

## Trade-offs

[If you didn't complete something, explain what you prioritized and why]

## 🤖 AI Assistance (optional)

If you used AI tools (ChatGPT, GitHub Copilot, etc.), please share:
- What parts you used AI for
- Sample prompts you used
- What outputs you modified and why
```

## ⏱️ Time Guidelines

This assessment is designed to take **3-4 hours maximum**.

If you don't finish everything, that's okay! Submit what you have with notes on:
- What you prioritized and why
- What you would do differently with more time
- Any technical decisions or trade-offs you made

## ❓ Common Issues & Solutions

### Build runner fails
```bash
flutter clean
rm -rf .dart_tool
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

This project includes pre-generated `.g.dart` files from `json_serializable` to reduce setup friction.

If you modify model files, you'll need to regenerate them:
```bash
dart run build_runner build --delete-conflicting-outputs
```

In production projects, these files are typically ignored in `.gitignore`, but for this evaluation we include them to help you get started quickly.

### Dependency conflicts
```bash
flutter pub upgrade
```

### Emulator issues
```bash
flutter doctor
flutter devices
```

## 🎯 Evaluation Criteria

We'll be looking at:

1. **Code Quality**: Clean, readable, well-organized code
2. **Architecture**: Proper separation of concerns following the project structure
3. **State Management**: Correct use of Riverpod patterns
4. **Error Handling**: Graceful handling of loading, error, and empty states
5. **UI Implementation**: Following the design specifications
6. **Git Usage**: Clear commit history showing your thought process
7. **Testing**: Appropriate test coverage for your implementations

Good luck! 🚀
