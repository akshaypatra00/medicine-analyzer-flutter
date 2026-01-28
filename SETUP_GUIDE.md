# Medicine Analyzer - Setup & Configuration Guide

## ✅ Project Status

✓ Clean Architecture implemented
✓ Riverpod state management configured
✓ Groq AI API integration layer created
✓ Complete UI/UX design system with glassmorphism
✓ Dark mode support
✓ JSON serialization models
✓ Local storage integration
✓ History tracking
✓ All dependencies installed

## 🚀 Quick Start

### 1. Environment Setup

Create a `.env` file in the project root:

```bash
GROQ_API_KEY=your_groq_api_key_here
```

Get your API key from: https://console.groq.com

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate JSON Serialization Code

```bash
flutter pub run build_runner build
```

### 4. Run the App

```bash
flutter run
```

## 📂 Project Structure

```
lib/
├── core/                          # Business core
│   ├── constants/
│   │   ├── app_constants.dart     # App-wide constants
│   │   └── app_strings.dart       # Localized strings
│   ├── theme/
│   │   ├── app_colors.dart        # Color palette
│   │   └── app_theme.dart         # Light & dark themes
│   └── utils/
│       └── app_utils.dart         # Helper utilities
│
├── data/                          # Data layer
│   ├── datasources/
│   │   └── groq_remote_data_source.dart  # Groq API calls
│   ├── models/
│   │   ├── medicine_analysis_model.dart  # JSON models
│   │   ├── condition_analysis_model.dart
│   │   └── search_history_model.dart
│   └── repositories/
│       ├── medicine_analysis_repository_impl.dart
│       └── search_history_repository_impl.dart
│
├── domain/                        # Business logic layer
│   ├── entities/
│   │   ├── medicine_analysis_entity.dart
│   │   ├── condition_analysis_entity.dart
│   │   └── search_history_entity.dart
│   ├── repositories/
│   │   ├── medicine_analysis_repository.dart
│   │   └── search_history_repository.dart
│   └── usecases/                  # (Extensible for future use cases)
│
└── presentation/                  # UI layer
    ├── pages/
    │   ├── home_page.dart         # Main search interface
    │   ├── history_page.dart      # Search history
    │   └── settings_page.dart     # Settings & legal
    ├── providers/
    │   ├── app_providers.dart     # Dependency injection
    │   ├── analysis_providers.dart # Analysis state
    │   └── history_providers.dart # History state
    └── widgets/
        ├── custom_widgets.dart    # Reusable UI components
        └── analysis_widgets.dart  # Analysis-specific widgets
```

## 🔧 Configuration

### Groq API Integration

The app uses Groq's `mixtral-8x7b-32768` model for AI analysis.

**Prompt Engineering:**
- Medicine analysis: Structured JSON with 11 categories
- Condition analysis: Dietary & lifestyle guidance
- All responses are medically neutral and non-prescriptive

### State Management (Riverpod)

Key providers:
- `medicineAnalysisProvider` - Medicine analysis FutureProvider
- `conditionAnalysisProvider` - Condition analysis FutureProvider
- `searchHistoryProvider` - Search history management
- `themeNotifierProvider` - Dark/light mode toggle

### Storage

- **SharedPreferences**: Local storage for search history
- **Flutter Secure Storage**: Safe credential storage (ready for API keys)

## 🎨 Design System

### Colors
- **Primary**: #6366F1 (Indigo)
- **Secondary**: #06B6D4 (Cyan)
- **Accent**: #8B5CF6 (Purple)
- **Success**: #10B981
- **Warning**: #F59E0B
- **Error**: #EF4444

### Typography
- Display: 32px - Page titles
- Headline: 24px - Section headers
- Title: 18px - Card titles  
- Body: 14-16px - Content
- Label: 12px - Metadata

## 🔐 Security & Safety

### Medical Disclaimer
The app includes mandatory disclaimers ensuring:
- ✅ Educational purposes only
- ✅ No medical diagnosis
- ✅ No prescription information
- ✅ Professional consultation encouraged

### Data Privacy
- No data sent to external servers except Groq API
- Local history stored in SharedPreferences
- No user tracking or analytics

## 📱 Platform Support

- **Android**: minSdk 21
- **iOS**: iOS 11+
- **Web**: Supported via Flutter Web
- **Desktop**: Extensible to Windows/macOS/Linux

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/widget_test.dart
```

## 📦 Building for Production

### Android APK
```bash
flutter build apk --split-per-abi
```

### iOS App
```bash
flutter build ipa
```

### Web
```bash
flutter build web
```

## 🐛 Troubleshooting

### API Key Not Working
- Verify `.env` file exists and contains correct key
- Check Groq console: https://console.groq.com
- Ensure API key hasn't exceeded rate limits

### Build Errors
```bash
# Clean build
flutter clean
flutter pub get
flutter pub run build_runner build
```

### Dependencies Issues
```bash
# Update all dependencies
flutter pub upgrade

# Check for issues
flutter doctor
```

## 📚 Key Features Implementation

### 1. Medicine Analysis
- Takes medicine name input
- Calls Groq API with structured prompt
- Returns JSON with:
  - Why to take
  - When to take (timing, frequency)
  - How to take (form, instructions)
  - Dosage guidance
  - Side effects (common & serious)
  - Contraindications
  - Alternatives
  - Food & lifestyle guidance
  - Missed dose info
  - Storage instructions

### 2. Condition Analysis
- Takes health condition/illness
- Returns dietary recommendations
- Suggests helpful habits
- Provides "when to see doctor" guidance

### 3. Search History
- Tracks recent searches
- Stores in LocalStorage
- Shows/clears history
- Quick access to recent searches

### 4. Settings
- Dark mode toggle
- App information
- Legal & disclaimer
- About section

## 🔌 API Integration

### Groq API Endpoint
```
POST https://api.groq.com/openai/v1/chat/completions
```

### Headers
```
Authorization: Bearer {GROQ_API_KEY}
Content-Type: application/json
```

### Request Structure
```json
{
  "model": "mixtral-8x7b-32768",
  "messages": [
    {
      "role": "user",
      "content": "{prompt_with_medicine_or_condition}"
    }
  ],
  "temperature": 0.3,
  "max_tokens": 2000
}
```

## 📝 Development Guidelines

### Adding New Features
1. Create entity in `domain/entities/`
2. Create model in `data/models/`
3. Add repository interface in `domain/repositories/`
4. Implement repository in `data/repositories/`
5. Create provider in `presentation/providers/`
6. Build UI in `presentation/pages/` or `presentation/widgets/`

### Code Style
- Use const constructors when possible
- Follow Dart naming conventions
- Comment complex logic
- Use proper error handling

## 🚢 Deployment Checklist

- [ ] Update version in `pubspec.yaml`
- [ ] Verify `.env` file with production API key
- [ ] Run `flutter analyze` - no errors
- [ ] Run `flutter test`
- [ ] Test on real device
- [ ] Update README with new features
- [ ] Create git tag for release
- [ ] Build APK/IPA for distribution

## 📞 Support & Documentation

- Flutter Docs: https://flutter.dev
- Groq API: https://www.groq.com
- Riverpod: https://riverpod.dev
- JSON Serialization: https://pub.dev/packages/json_serializable

## 📄 License

This project is licensed under the MIT License.

## ⚠️ Medical Disclaimer

This application provides educational information about medicines and health conditions. It is **NOT** a substitute for professional medical advice. Always consult with a qualified healthcare professional.

---

**Built with ❤️ for trustworthy health information**
