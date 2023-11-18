import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductController {
  List<PlatformFile> imageFiles = [];

  Future<void> pickImages(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result == null) return;

      imageFiles = result.files;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  List<String> getSelectedImagesPath() {
    List<String> imagePaths = [];
    for (var imageFile in imageFiles) {
      imagePaths.add(imageFile.path!);
    }
    return imagePaths;
  }

  void removeImage(int index) {
    imageFiles.removeAt(index);
  }

  Future<List<String>> uploadImages(List<PlatformFile> imageFiles) async {
    List<String> imageUrls = [];

    try {
      for (var imageFile in imageFiles) {
        final storageReference = FirebaseStorage.instance
            .ref()
            .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final Uint8List fileBytes = imageFile.bytes!;
        await storageReference.putData(fileBytes);
        final String imageUrl = await storageReference.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (e) {
      print("Erreur lors du téléversement des images : $e");
      rethrow;
    }
  }

  Future<void> saveProduct({
    required String title,
    required String description,
    required String price,
    required String category,
  }) async {
    try {
      List<String> imageUrls = await uploadImages(imageFiles);
      // Reste du code...
    } catch (e) {
      print("Erreur lors de la création du produit : $e");
      rethrow;
    }
  }
}
