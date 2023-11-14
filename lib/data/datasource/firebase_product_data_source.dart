import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diarraapp/comon/models/product_models.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/entries/product_entitie.dart';

class FirebaseProductDataSource {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(ProductModel product) async {
    await productsCollection.add({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'images': product.imagePaths,
    });
    }
     final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> downloadUrls = [];

    for (final image in images) {
      final Reference storageReference = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(image);

      await uploadTask.whenComplete(() async {
        final downloadUrl = await storageReference.getDownloadURL();
        downloadUrls.add(downloadUrl);
      });
    }

    return downloadUrls;
  }
  Future<void> updateProduct(String productId, String newtitle,
  String newdescription,String newprice,String newimages
  ) async {
    await productsCollection.doc(productId).update({
      'title': newtitle,
      'description': newdescription,
      'price': newprice,
      'images':   newimages,
    });
  }
    
  Future<void> deleteProduct(String productId) async {
    await productsCollection.doc(productId).delete();
  }
  //obtenir les products
  Stream<List<ProductModel>> products() {
    return productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromEntity(ProductEntity(
   id:  doc.id,
        title: doc['title'],
        description: doc['description'],
        price: doc['price'],
        imageUrls: doc['images'],
      ))).toList();
    });

  }
}