import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img; // Add this import at the top
import '../examples.dart';
import '../secrets.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  File? _image;
  String _result = '';
  final picker = ImagePicker();
  late GenerativeModel _model;
  String _prompt = '';
  String _format = '';

  Future<void> _analyzeReceipt() async {
    setState(() {
      _result = 'Processing...';
    });
    try {
      if (_image == null) {
        setState(() {
          _result = 'No image selected';
        });
      } else {
        final resizedBytes = await _resizeImage(_image!);
        final outputExample = (_format == 'JSON') ? jsonExample : xmlExample;

        String prompt = _prompt
            .replaceAll('{{output_format}}', _format)
            .replaceAll('{{output_example}}', outputExample);
        print (prompt);
        final content = Content.multi([
          DataPart('image/jpeg', resizedBytes!),
          TextPart(prompt),
        ]);
        final response = await _model.generateContent([content]);
        if (response.text == null) {
          setState(() {
            _result = "There was an error with the response";
          });
        } else {
          setState(() {
            _result = response.text!;
          });
        }
      }
    } on Exception catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    });
  }

  // Reduce the image weight
  Future<Uint8List?> _resizeImage(File imageFile, {int maxWidth = 768}) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        return null; // Indicate decoding failure
      }

      // Resize the image, maintaining aspect ratio
      final resizedImage = img.copyResize(image, width: maxWidth);

      // Encode the resized image as JPEG
      final resizedBytes =
          img.encodeJpg(resizedImage, quality: 85); // Adjust quality as needed

      return Uint8List.fromList(resizedBytes);
    } catch (e) {
      print('Error resizing image: $e');
      return null; // Indicate resizing failure
    }
  }

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
    _prompt = """
You are an expert receipt data extraction bot. Analyze the following receipt and extract the purchase date, list of items, price of each item, and the total.

Receipt: {{receipt_image}}

Output the extracted data in {{output_format}} format, following this structure:
{{output_example}}
""";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker and AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('JSON'),
                Switch(
                  value: _format == 'XML',
                  onChanged: (bool value) {
                    setState(() {
                      _format = value ? 'XML' : 'JSON';
                    });
                  },
                ),
                const Text('XML'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => getImage(ImageSource.camera),
                  child: const Text('Take a photo'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: const Text('Choose from gallery'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _analyzeReceipt(),
                    child: const Text('Analyze Receipt'))
              ],
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Text(
                'Result:\n$_result',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
