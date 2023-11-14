import 'package:image_picker/image_picker.dart';

class AddProductController {
  List<String> _selectedImages = [];

  Future<void> pickImages() async {
    final result = await ImagePicker().pickMultiImage();
    if (result != null) {
      _selectedImages = result.map((file) => file.path).toList();
    }
  }

  Future<List<String>> getImagePaths() async {
    return _selectedImages;
  }

  void removeImage(String path) {
    _selectedImages.remove(path);
  }

  void saveProduct({
    required String title,
    required String description,
    required double price,
  }) {
    // Ajoutez la logique pour enregistrer le produit avec les détails fournis.
    // Vous pouvez utiliser un autre bloc ou service ici pour gérer la logique métier.
    print('Produit enregistré : $title, $description, $price');
    print('Images sélectionnées : $_selectedImages');
  }
}
