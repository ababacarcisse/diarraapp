import 'package:diarraapp/domain/repositories/productRepositorie.dart';
import 'package:flutter/material.dart';
import '../../data/repository/firebase_product_repository.dart';
import '../../domain/usecase/product_interactor.dart';
import '../../providers/provider_product.dart';
import 'controllers/add_product_controller.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}
class _AddProductPageState extends State<AddProductPage> {
  late AddProductController _controller;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  final productRepository = FirebaseProductRepository(); // Utilisez l'implémentation concrète ici
    final productInteractor = ProductInteractor(productRepository);
    _controller = AddProductController(productInteractor);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _controller.pickImages();
                setState(() {}); // Rafraîchit l'affichage des images
              },
              child: const Text('Sélectionner des photos'),
            ),
            const SizedBox(height: 16),
            _buildImageList(),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
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
              onPressed: () {
                _controller.saveProduct(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  price: double.tryParse(_priceController.text) ?? 0.0,
                );
              },
              child: const Text('Ajouter le produit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageList() {
    return FutureBuilder<List<String>>(
      future: _controller.getImagePaths(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Erreur : ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: snapshot.data!
                  .map((path) => _buildSelectedImage(path))
                  .toList(),
            );
          } else {
            return const Text('Aucune image sélectionnée');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildSelectedImage(String path) {
    return Stack(
      children: [
        Image.network(
          Uri.parse(path).toString(),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              _controller.removeImage(path);
              setState(() {}); // Rafraîchit l'affichage des images
            },
          ),
        ),
      ],
    );
  }
}
