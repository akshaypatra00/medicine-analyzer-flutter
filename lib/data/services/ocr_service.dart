import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class OcrService {
  static final _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );
  static final _imagePicker = ImagePicker();

  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
      return null;
    }
  }

  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      return null;
    }
  }

  static Future<String?> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      String extractedText = '';
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          extractedText += '${line.text}\n';
        }
      }

      return extractedText.trim().isNotEmpty ? extractedText.trim() : null;
    } catch (e) {
      debugPrint('Error extracting text from image: $e');
      return null;
    }
  }

  static Future<String?> extractMedicineNameFromImage(File imageFile) async {
    try {
      final text = await extractTextFromImage(imageFile);
      if (text == null || text.isEmpty) return null;

      final lines = text
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      if (lines.isEmpty) return null;

      final medicineLines = lines
          .where(
            (line) => line.length < 150 && !line.contains(RegExp(r'[.!?]$')),
          )
          .toList();

      if (medicineLines.isNotEmpty) {
        medicineLines.sort((a, b) => a.length.compareTo(b.length));
        return medicineLines.first.trim();
      }

      return lines.first.trim();
    } catch (e) {
      debugPrint('Error extracting medicine name: $e');
      return null;
    }
  }

  static Future<void> dispose() async {
    await _textRecognizer.close();
  }
}
