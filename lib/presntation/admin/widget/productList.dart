import 'package:diarraapp/presntation/providers/provider_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entries/product_entitie.dart';
import '../../../domain/usecase/product/get_AllProduct_useCase.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
             // Utilisez le fournisseur pour obtenir l'instance de GetAllProductsUseCase
    final getAllProductsUseCase = ref.read<GetAllProductsUseCase>(getAllProductsUseCaseProvider);
          return FutureBuilder<List<Product>>(
        future: getAllProductsUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun produit trouvé.'));
          } else {
            // Affiche la liste des produits
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,

              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                            context.pushNamed('/adminPage/editproduct', pathParameters: {
      'productId': product.id,
      'title': product.title,
      'description': product.description,
      // Ajoutez d'autres données du produit ici
    });
  },
),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          
                          
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      );

        }
     );



 

  }
}
