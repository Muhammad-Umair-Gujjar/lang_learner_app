import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class CloudinaryUploader extends StatefulWidget {
  @override
  _CloudinaryUploaderState createState() => _CloudinaryUploaderState();
}

class _CloudinaryUploaderState extends State<CloudinaryUploader> {
  File? _image;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  // TODO: Replace with your own Cloudinary info
  final String cloudName = 'dbvumwf7c';
  final String uploadPreset = 'test_mode';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadToCloudinary() async {
    if (_image == null) return;

    setState(() => _isUploading = true);

    final url =
    Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final mimeType = lookupMimeType(_image!.path);
    final mimeSplit = mimeType?.split('/');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        _image!.path,
        contentType: mimeSplit != null
            ? MediaType(mimeSplit[0], mimeSplit[1])
            : null,
      ));

    final response = await request.send();
    final resData = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(resData.body);
      setState(() {
        _uploadedImageUrl = data['secure_url'];
      });
    } else {
      print('Upload failed: ${resData.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed!')),
      );
    }

    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image to Cloudinary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : Placeholder(fallbackHeight: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 10),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _uploadToCloudinary,
              child: Text('Upload to Cloudinary'),
            ),
            if (_uploadedImageUrl != null) ...[
              SizedBox(height: 20),
              Text('Uploaded Image:', style: TextStyle(fontWeight: FontWeight.bold)),
              Image.network(_uploadedImageUrl!),
            ]
          ],
        ),
      ),
    );
  }
}
