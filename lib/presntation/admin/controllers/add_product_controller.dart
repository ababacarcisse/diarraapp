import 'dart:typed_data';

import 'package:diarraapp/data/repository/firebase_product_repository.dart';
import 'package:diarraapp/domain/entries/product_entitie.dart';
import 'package:diarraapp/domain/repositories/productRepositorie.dart';
import 'package:diarraapp/domain/usecase/product/create_product_use_case.dart';
import 'package:diarraapp/presntation/providers/provider_product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class AddProductController {
 // Utilisez le constructeur pour ing   itialiser createProductUseCase
 final CreateProductUseCase createProductUseCase=CreateProductUseCase(FirebaseProductRepository());
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
    
    final product = Product(
      title: title,
      description: description,
      price: price,
      imageUrls: imageUrls, id: '', category: category,
    );
        await   createProductUseCase.execute(product);

   } catch (e) {
      print("Erreur lors de la création du produit : $e");
      rethrow;
    }
  }
}
