# Medicine Analyzer App - Development Instructions

This is a production-ready Flutter application for analyzing medicines and health conditions using Groq AI.

## Project Overview

**Application**: Medicine Analyzer
**Framework**: Flutter (latest stable)
**State Management**: Riverpod
**AI Backend**: Groq API (mixtral-8x7b-32768)
**Architecture**: Clean Architecture (Domain, Data, Presentation)
**Database**: SharedPreferences (local storage)

## Key Features

✓ Medicine search and analysis
✓ Health condition nutrition guidance
✓ Camera-based medicine scanning (framework ready)
✓ Search history with local storage
✓ Dark mode support
✓ Glassmorphism UI design
✓ Medical-grade information safety
✓ Complete localization support

## Project Structure

```
lib/
├── core/              # Constants, theme, utilities
├── data/              # API calls, models, repositories
├── domain/            # Business logic, entities
└── presentation/      # UI, pages, widgets, providers
```

## Setup Instructions

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure Environment
Create `.env` file:
```
GROQ_API_KEY=your_key_here
```

### 3. Generate Code
```bash
flutter pub run build_runner build
```

### 4. Run App
```bash
flutter run
```

## Important Locations

- **API Integration**: [lib/data/datasources/groq_remote_data_source.dart](lib/data/datasources/groq_remote_data_source.dart)
- **State Management**: [lib/presentation/providers/](lib/presentation/providers/)
- **UI Components**: [lib/presentation/widgets/](lib/presentation/widgets/)
- **Main App**: [lib/main.dart](lib/main.dart)
- **Theme**: [lib/core/theme/app_theme.dart](lib/core/theme/app_theme.dart)

## Development Guidelines

### Adding Features
1. Create entity in `domain/entities/`
2. Create model in `data/models/`
3. Update datasource if API call needed
4. Implement repository
5. Create provider in `presentation/providers/`
6. Build UI components

### Code Quality
- Run `flutter analyze` before commits
- Follow Dart conventions
- Use const constructors
- Comment complex logic
- Test before pushing

## Common Commands

```bash
# Analysis
flutter analyze

# Testing
flutter test

# Code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Build
flutter build apk --split-per-abi    # Android
flutter build ipa                     # iOS
flutter build web                     # Web

# Clean
flutter clean && flutter pub get
```

## Debugging

Enable debug logging:
```dart
AppUtils.log('message');
```

View logs:
```bash
flutter logs
```

## Documentation

- [README.md](README.md) - Project overview
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Configuration guide
- [ADVANCED_DEVELOPMENT.md](ADVANCED_DEVELOPMENT.md) - Extension guide

## Architecture Details

### Clean Architecture Layers

**Presentation Layer**
- Pages: Complete screens
- Providers: Riverpod state management
- Widgets: Reusable UI components

**Domain Layer**
- Entities: Pure business models
- Repositories: Abstract interfaces
- Use Cases: (Extensible)

**Data Layer**
- Models: JSON serializable
- Datasources: API/storage access
- Repositories: Interface implementations

### State Management with Riverpod

```dart
// Read provider
final data = ref.watch(dataProvider);

// Watch async operations
final asyncData = ref.watch(futureProvider);

// Trigger side effects
ref.read(providerWithSideEffect);

// Invalidate cache
ref.invalidate(provider);
```

## API Integration

### Groq AI Configuration

**Model**: `mixtral-8x7b-32768`
**Endpoint**: `https://api.groq.com/openai/v1/chat/completions`
**Safety**: Temperature 0.3 (low randomness for medical info)

### Prompt Engineering

Prompts are designed to:
- Return structured JSON
- Avoid medical diagnosis
- Provide educational information
- Be medically safe and neutral

## Testing

Unit test example:
```dart
void main() {
  test('Medicine analysis entity creation', () {
    final entity = MedicineAnalysisEntity(...);
    expect(entity.name, 'Aspirin');
  });
}
```

## Deployment

### Pre-release Checklist
- [ ] Update version in pubspec.yaml
- [ ] flutter analyze passes
- [ ] flutter test passes
- [ ] Test on physical device
- [ ] Update CHANGELOG
- [ ] Create git tag

### Release Process
1. Update version and changelog
2. Run tests
3. Build for platforms
4. Sign and notarize
5. Upload to stores

## Security

- Environment variables in .env
- Flutter Secure Storage ready
- No hardcoded credentials
- API key from environment
- Sanitized user inputs

## Performance

- Riverpod caching built-in
- JSON parsing optimized
- UI rebuilds minimized
- Image caching ready

## Support & Resources

- [Flutter Docs](https://flutter.dev)
- [Riverpod](https://riverpod.dev)
- [Groq API](https://www.groq.com)
- [Material Design](https://material.io/design)

## Important Notes

⚠️ **Medical Disclaimer**: This app provides educational information only. Always consult professionals for medical advice.

❤️ **Built with care** for trustworthy health information.

---

**Last Updated**: January 28, 2026
**Maintainer**: Medicine Analyzer Team
