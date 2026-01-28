<<<<<<< HEAD
# Medicine Analyzer App

A production-ready Flutter mobile application that helps users understand medicines and health conditions in a clear, structured, and responsible way.

## 🎯 Features

### 🔍 Input Methods
- **Search by Medicine Name**: Text-based search for specific medicines
- **Scan Medicine**: Capture medicine images using device camera
- **Upload Image**: Select medicine photos from gallery
- **OCR Extraction**: Automatic text recognition from images with manual correction

### 🧠 AI Integration
- **Groq AI-Powered**: All intelligence provided by Groq API
- **Structured JSON Responses**: Medical information returned in organized format
- **Medical Safety**: Neutral, non-prescriptive information

### 💊 Medicine Analysis
Comprehensive medicine information in glass-style cards:
- Why to take this medicine
- When to take it (timing, frequency, before/after food)
- How to take (form type, instructions)
- Dosage guidance (adult, pediatric, geriatric)
- Possible side effects (common & serious)
- Who should avoid
- Alternative medicines
- Food & lifestyle guidance
- Missed dose guidance
- Storage instructions

### 🩺 Health Condition Feature
Dedicated condition analysis:
- Enter illness or health issue
- Get dietary recommendations
- Foods to avoid
- Helpful habits
- When to seek professional help

### 🎨 Beautiful UI/UX
- **Glassmorphism Design**: Modern glass effect with blur and transparency
- **Soft Gradients**: Blue, purple, teal color palette
- **Dark Mode**: Full dark mode support with consistent design
- **Smooth Animations**: Elegant transitions and loading states
- **Trust-Focused**: Calm, non-alarming language and visual hierarchy

### 📊 User Features
- **Search History**: Track previous searches
- **Settings**: Dark mode toggle, app info
- **Legal**: Medical disclaimer and information
- **Responsive Design**: Works on all device sizes

## 🏗️ Architecture

### Clean Architecture Implementation
```
lib/
├── core/              # Business logic
│   ├── constants/     # App-wide constants
│   ├── theme/         # Theme & UI design
│   └── utils/         # Helper utilities
├── data/              # Data layer
│   ├── datasources/   # API calls (Groq)
│   ├── models/        # JSON serializable models
│   └── repositories/  # Data repository implementations
├── domain/            # Business logic layer
│   ├── entities/      # Core business entities
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business use cases
└── presentation/      # UI layer
    ├── pages/         # Full screens
    ├── providers/     # Riverpod state management
    └── widgets/       # Reusable components
```

### State Management
- **Riverpod**: Modern reactive state management
- **FutureProvider**: Async operation handling
- **StateProvider**: Local state management

### Technology Stack
- **Framework**: Flutter (latest stable)
- **State Management**: Riverpod
- **API Client**: Dio
- **JSON**: json_serializable
- **Camera**: Camera plugin
- **OCR**: Google ML Kit
- **Local Storage**: Shared Preferences
- **Environment**: flutter_dotenv

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- Groq API Key

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd medine_analyser
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate JSON serialization code**
```bash
flutter pub run build_runner build
```

4. **Setup environment variables**
Create `.env` file in project root:
```
GROQ_API_KEY=your_groq_api_key_here
```

Get your API key from [Groq Console](https://console.groq.com)

5. **Run the application**
```bash
flutter run
```

## 📱 App Structure

### Screens

1. **Splash Screen** - App initialization with branding
2. **Home Screen** - Main entry point with search options
3. **Medicine Analysis** - Detailed medicine information
4. **Condition Analysis** - Health condition guidance
5. **Search History** - Track previous searches
6. **Settings** - User preferences and legal info

## 🔐 Safety & Compliance

### Medical Disclaimer
The app includes mandatory disclaimers:
- "This information is for educational purposes only and does not replace medical advice"
- Encourages professional consultation
- Uses neutral, non-judgmental language

### Safety Rules
- ✅ No diagnosis
- ✅ No prescriptions
- ✅ No exact dosages
- ✅ Neutral information only
- ✅ Professional consultation encouraged

## 🎨 Design System

### Colors
- **Primary**: Indigo (#6366F1)
- **Secondary**: Cyan (#06B6D4)
- **Accent**: Purple (#8B5CF6)
- **Success**: Green (#10B981)
- **Warning**: Amber (#F59E0B)
- **Error**: Red (#EF4444)

### Typography
- **Display**: 32px - Page titles
- **Headline**: 24px - Section headers
- **Title**: 18px - Card titles
- **Body**: 14-16px - Main content
- **Label**: 12px - Metadata

## 🔄 Groq API Integration

### Prompt Engineering
The app uses carefully crafted prompts to ensure:
1. Structured JSON responses
2. Medical neutrality
3. Safety-focused information
4. Clear categorization

### Example Requests
```dart
// Medicine Analysis
"Analyze this medicine: Aspirin"

// Condition Analysis
"What should I eat if I have this condition: Fever"
```

## 📝 Environment Setup

### .env File
```
GROQ_API_KEY=gsk_your_key_here
```

### Platform-Specific Setup

**Android** (android/app/build.gradle)
- Min SDK: 21
- Camera & Gallery permissions

**iOS** (ios/Runner/Info.plist)
- Camera usage description
- Photo library usage description

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Build for production:
```bash
flutter build apk      # Android
flutter build ipa      # iOS
```

## 📚 API Reference

### Groq API
- **Base URL**: https://api.groq.com/openai/v1
- **Model**: mixtral-8x7b-32768
- **Rate Limit**: Based on Groq's pricing

### Medicine Analysis Response
```json
{
  "name": "medicine name",
  "whyToTake": {
    "description": "...",
    "benefits": ["..."]
  },
  "whenToTake": {
    "timing": "morning/evening/night",
    "frequency": "once daily",
    "beforeFood": true,
    "afterFood": false
  },
  ...
}
```

## 🐛 Debugging

Enable verbose logging:
```dart
AppUtils.log('message'); // Custom logging
```

Check errors:
```bash
flutter analyze
```

## 📞 Support

For issues and feature requests:
1. Check existing issues
2. Provide detailed reproduction steps
3. Include Flutter version: `flutter --version`
4. Include device info

## 📄 License

This project is licensed under the MIT License.

## ⚠️ Medical Disclaimer

This application provides educational information about medicines and health conditions. It is **NOT** a substitute for professional medical advice, diagnosis, or treatment. Always consult with a qualified healthcare professional before making any health-related decisions.

## 🙏 Acknowledgments

- Built with Flutter
- Powered by Groq AI
- Inspired by trust-focused medical design
- Crafted with care for user safety

=======
# medicine-analyzer-flutter
>>>>>>> 6e8e274eb26b2987f456318a18b9ad08b3a19e8d
