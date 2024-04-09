import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/providers/providers.dart';
import 'package:gemini_chat_bot/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class SendImageScreen extends ConsumerStatefulWidget {
  const SendImageScreen({super.key});

  @override
  ConsumerState<SendImageScreen> createState() => _SendImageScreenState();
}

class _SendImageScreenState extends ConsumerState<SendImageScreen> {
  XFile? image;
  late final TextEditingController _promptController;
  bool isLoading = false;
  final apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  void initState() {
    _pickImage();
    _promptController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedImage = await pickImage();
    if (pickedImage == null) {
      return;
    }
    setState(() => image = pickedImage);
  }

  void _removeImage() async {
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Image Prompt!'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Container(
              height: 400,
              color: Colors.grey[200],
              child: image == null
                  ? const Center(
                      child: Text(
                        'No Image Selected',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    ),
            ),
            // Pick and Remove image buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed: _removeImage,
                      child: const Text('Remove Image'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Text Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _promptController,
                decoration: const InputDecoration(
                  hintText: 'Write something about the image...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 100),
            // Send Message Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (image == null) return;
                        setState(() => isLoading = true);
                        await ref.read(chatProvider).sendMessage(
                              apiKey: apiKey,
                              image: image,
                              promptText: _promptController.text.trim(),
                            );
                        setState(() => isLoading = false);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Send Message'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
