import 'package:image_picker/image_picker.dart';

import '../../../domain/entries/product_entitie.dart';
import '../../../domain/usecase/product_interactor.dart';
class AddProductController {
  final ProductInteractor _productInteractor;

  AddProductController(this._productInteractor);
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

  Future<void> saveProduct({
    required String title,
    required String description,
    required double price,
  }) async {
    final product = ProductEntity(
      
      title: title,
      description: description,
      price: price,
      imageUrls: _selectedImages,
    );
    await _productInteractor.addProduct(product);
  }
}
