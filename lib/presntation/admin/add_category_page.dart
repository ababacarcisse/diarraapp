import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../comon/models/categorie_models.dart';
import '../../providers/providerCategory.dart';
class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Ajouter une catégorie'),
      ),
      body: SingleChildScrollView( // Utilisez SingleChildScrollView pour éviter le dépassement de taille
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child:
                AddCategoryForm(),
            
          ),
        ),
      ),
    );
  }
}

class AddCategoryForm extends StatefulWidget {
   const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}
class _AddCategoryFormState extends State<AddCategoryForm> {
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, ref, _) {
        final categoryUseCase = ref.read(categoryUseCaseProvider);
   return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nom de la catégorie :'),
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              hintText: 'Entrez le nom de la catégorie',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final category = CategoryModel(name: _categoryController.text,id: null);
    
              try {
                await categoryUseCase.addCategory(category);
                // Affichez un SnackBar en cas de succès
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Catégorie ajoutée avec succès.'),
                  ),
                );
                // Effacez le texte du contrôleur
                _categoryController.clear();
              } catch (e) {
                // Affichez un SnackBar en cas d'erreur
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Erreur lors de l\'ajout de la catégorie.'),
                  ),
                );
              }
            },
            child: const Text('Ajouter la catégorie'),
          ),
        ],
      );
   
      },
   );
  }
}
//affichév les categories

final categoryListProvider = StreamProvider<List<CategoryModel>>((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return categoryRepository.getCategories();
});

class CategoryListWidget extends ConsumerWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des catégories'),
      ),
      body: categories.when(
        data: (categoryList) {
          return ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];

              return ListTile(
                title: Text(category.name),
                leading: Icon(Icons.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Mettez en œuvre la logique d'édition ici
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Mettez en œuvre la logique de suppression ici
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Center(
          child: Text('Erreur lors du chargement des catégories.'),
        ),
      ),
    );
  }
}
