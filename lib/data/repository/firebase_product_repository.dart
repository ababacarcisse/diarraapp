import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

import '../../domain/entries/product_entitie.dart';
import '../../domain/repositories/productRepositorie.dart';

class FirebaseProductRepository implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createProduct(Product product) async {
    try {
     
      // Ajout du produit avec les URLs des images dans la collection Firestore
      await _firestore.collection('products').add(product.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Erreur lors de la création du produit : $e");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      // Mise à jour du produit dans la collection Firestore
      await _firestore.collection('products').doc(product.id).update(product.toMap());
    } catch (e) {
      print("Erreur lors de la mise à jour du produit : $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      // Suppression du produit dans la collection Firestore
      await _firestore.collection('products').doc(productId).delete();
      // Ajoutez ici la logique pour supprimer les images associées de Firebase Storage si nécessaire
    } catch (e) {
      print("Erreur lors de la suppression du produit : $e");
      rethrow;
    }
  }

  @override
  Future<Product?> getProductById(String productId) async {
    try {
      // Récupération du produit par son ID depuis Firestore
      var productDoc = await _firestore.collection('products').doc(productId).get();
      if (productDoc.exists) {
        return Product.fromMap(productDoc.data()!);
      }
      return null;
    } catch (e) {
      print("Erreur lors de la récupération du produit : $e");
      rethrow;
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      // Récupération de tous les produits depuis Firestore
      var querySnapshot = await _firestore.collection('products').get();
      return querySnapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      print("Erreur lors de la récupération de tous les produits : $e");
      rethrow;
    }
  }

  // Méthode pour téléverser les images dans Firebase Storage
  // ...
}
