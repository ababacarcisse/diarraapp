import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'controllers/add_product_controller.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}
class _AddProductPageState extends State<AddProductPage> {
   final AddProductController _controller=AddProductController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _controller.pickImages(context, );
                  setState(() {
                  });
                },

                child: const Text('Sélectionner des photos'),
              ),
              const SizedBox(height: 16),
        _buildSelectedImage(),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Categorie'),
              
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: null,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                //      List<String> imageUrls = await galleryService.uploadImages(context, imageFiles);

                onPressed: () async{
                  await _controller.saveProduct(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    price: _priceController.text,
                    category: _categoryController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Ajouter le produit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
// ...

Widget _buildSelectedImage() {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _controller.imageFiles.length,
      itemBuilder: (context, index) {
        final imageFile = _controller.imageFiles[index];

        return Stack(
          children: [
            Image.memory(
              Uint8List.fromList(imageFile.bytes!),
              width: 200,
              height: 200,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  // Supprimez l'image de la liste
                  _controller.removeImage(index);
                  setState(() {});
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}

// ...

}