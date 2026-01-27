# Flutter AI & ML Showcase
This project is a comprehensive Flutter application designed to demonstrate the power and versatility of integrating modern **Artificial Intelligence (AI)** and **Machine Learning (ML)** capabilities into mobile apps. It leverages Google's cutting-edge technologies, including the **Google Generative AI SDK** for advanced content creation and the **ML Kit library** for a wide range of on-device vision and language processing tasks.

## 🚀 Features
This application showcases the following AI/ML features, all running locally on the user's device (unless specified otherwise):

## ✨ Generative AI:
* Content Generation: Utilizes Google's generative models to create text-based content from user prompts (powered by the Google Generative AI SDK).

## 🖼️ Vision & Image Analysis (ML Kit):
* Text Recognition: Extracts and processes text directly from images.
* Barcode Scanning: Detects and decodes multiple barcode formats in real-time.
* Image Labeling: Identifies objects, scenes, and concepts within an image, providing descriptive labels.
* Face Detection: Locates faces in an image and identifies key facial landmarks.

## •📝 Natural Language Processing (ML Kit):
* Language Identification: Determines the language of a given text string.
* Entity Extraction: Identifies and extracts specific entities (like locations, dates, and people) from text.

## 🏛️ Architecture 
To ensure the project is scalable, maintainable, and testable, it is built following the Model-View-ViewModel (MVVM) architectural pattern.
* Model: Represents the data and business logic. This includes data structures for ML Kit results and interaction logic with the AI/ML services.
* View: The UI layer, composed of Flutter widgets. It is responsible for displaying data and capturing user input, but it contains no business logic. It observes the ViewModel for state changes.
* ViewModel: Acts as a bridge between the Model and the View. It holds the application's state, handles user actions, processes data from the Model, and exposes it to the View via streams or notifiers. This separation makes the logic independent of the UI, facilitating easier unit testing.

## 🛠️ Tech Stack & Libraries
This project is built with a modern and powerful set of technologies:

* **Flutter**: Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.
* **Dart**: The programming language used for Flutter development.

## Artificial Intelligence & Machine Learning
* **Google AI SDK** : The official Dart SDK for accessing Google's latest generative AI models (like Gemini) for advanced content generation and reasoning.
* **Google ML Kit** : A suite of packages providing on-device machine learning capabilities.
  The specific components used are:
  * google_mlkit_text_recognition
  * google_mlkit_barcode_scanning
  * google_mlkit_language_id
  * google_mlkit_entity_extraction
  * google_mlkit_image_labeling
  * google_mlkit_face_detection
* **TensorFlow Lite**: Although ML Kit is the primary on-device library, TensorFlow Lite is included for potential custom model integration.
## Utilities:
* **Image Picker**: A Flutter plugin for selecting images from the device's camera or gallery to be used as input for the vision models.

## ⚙️ Getting StartedPrerequisites
* Flutter SDK installed (version 3.x.x or higher).
* An IDE like VS Code or Android Studio.
* An API key for the Google Generative AI service.
## Installation & Setup
* 1.Clone the repository:Kotlin
  * git clone https://github.com/your-username/your-repository-name.git
  * cd your-repository-name
* 2.Install dependencies:Shell Scriptbash
  * flutter pub get
