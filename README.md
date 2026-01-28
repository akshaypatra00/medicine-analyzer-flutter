🧬 Medicine Analyzer App

A production-ready Flutter mobile application designed to help people understand medicines and health conditions in a clear, structured, and responsible way.

This app focuses on trust, simplicity, and safety, combining modern UI design with AI-powered analysis to make medical information easier to understand — without replacing professional medical advice.

✨ Why This App Exists

Understanding medicines shouldn’t feel confusing or risky.
Medicine Analyzer was built to:

Explain medicines in plain, structured language

Reduce misinformation

Encourage responsible usage

Maintain a calm, medical-grade experience

⚠️ This app is for educational purposes only and does not replace professional medical advice.

🎯 Core Features
🔍 Multiple Input Methods

Search by medicine name

Scan medicine using camera

Upload medicine images from gallery

OCR extraction with manual correction support

🧠 AI-Powered Intelligence

Powered by Groq AI

Uses carefully designed prompts

Returns structured JSON for reliable UI rendering

Medical information is neutral and non-prescriptive

💊 Medicine Analysis (Categorized & Clear)

Each medicine is broken into easy-to-read sections:

Why the medicine is used

When to take it (timing, before/after food)

How to take it (tablet, syrup, etc.)

General dosage guidance (non-prescriptive)

Possible side effects (common & serious)

Who should avoid it

Alternative medicines

Food & lifestyle guidance

Missed dose instructions

Storage instructions

All information is displayed in glassy, modern cards for clarity.

🩺 Health Condition Guidance

Users can also enter a health condition or illness and receive:

Recommended foods

Foods to avoid

Helpful daily habits

Guidance on when to consult a doctor

🎨 UI & Design Philosophy

Glassmorphism UI with blur & transparency

Soft gradients (blue, teal, purple tones)

Fully supported Dark Mode

Smooth animations & loading states

Calm language and visual hierarchy

Designed to feel trustworthy, modern, and human

🧱 Architecture Overview

The project follows Clean Architecture, making it scalable and maintainable.

lib/
├── core/              # App constants, themes, utilities
├── data/              # API calls, models, repositories
├── domain/            # Business entities & interfaces
└── presentation/      # UI, providers, widgets

State Management

Riverpod

Async handling with FutureProvider

Local state via StateProvider

🛠️ Tech Stack

Flutter (3.9.2+)

Riverpod (state management)

Dio (networking)

Groq AI (medicine & condition analysis)

Google ML Kit (OCR)

SharedPreferences (local storage)

flutter_dotenv (environment variables)

🚀 Getting Started
Prerequisites

Flutter SDK (≥ 3.9.2)

Dart SDK

Groq API key

Installation

1️⃣ Clone the repository

git clone https://github.com/akshaypatra00/medicine-analyzer-flutter.git
cd medicine-analyzer-flutter


2️⃣ Install dependencies

flutter pub get


3️⃣ Generate JSON files

flutter pub run build_runner build


4️⃣ Set up environment variables
Create a .env file in the root directory:

GROQ_API_KEY=your_groq_api_key_here


5️⃣ Run the app

flutter run

📱 Screens Included

Splash Screen

Home (Search & Scan)

Medicine Analysis

Condition Analysis

Search History

Settings & Legal Info

🔐 Safety & Responsibility
Medical Safety Rules

❌ No diagnosis

❌ No prescriptions

❌ No exact dosage recommendations

✅ Neutral, educational information

✅ Professional consultation encouraged

Clear disclaimers are shown throughout the app.

🧪 Testing & Build

Run tests:

flutter test


Build for production:

flutter build apk     # Android
flutter build ipa     # iOS

🧠 Groq AI Usage

The app uses structured prompts to ensure:

Predictable JSON responses

Medical neutrality

Clear categorization

Safe explanations

Example prompts:

Analyze this medicine: Paracetamol
What should I eat if I have this condition: Fever

👨‍💻 Developer

Developed by:
Akshay Patra

Flutter Developer

Focused on clean architecture & real-world usability

Passionate about building trust-focused, user-safe applications

📄 License

This project is licensed under the MIT License.

⚠️ Final Medical Disclaimer

This application provides educational information only.
It is not a substitute for professional medical advice, diagnosis, or treatment.
Always consult a qualified healthcare professional before making health decisions.
