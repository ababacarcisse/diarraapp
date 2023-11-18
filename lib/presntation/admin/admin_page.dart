
// Importez également 'NewletterPage' si vous en avez besoin.

import 'package:diarraapp/presntation/admin/add_product_page..dart';
import 'package:diarraapp/presntation/admin/add_category_page.dart';
import 'package:diarraapp/presntation/admin/commandPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'DashboardPage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    final User? user = _auth.currentUser;

    if (user == null) {
      context.go('/admin/login');
    }
  }
  int activePageIndex = 0; // Index de la page active
  List<Widget> page = [
  const DashboardPage(),
   const AddProductPage(),
   const AddCategoryPage(),
  const CommandPage(),
 // NewletterPage(),
];
  List<String> sectionNames = [
    'Tableau de bord',
    'Ajouter un Produit',
    'Ajoutez une Catégorie',
    'Commandes',
   
    // Ajoutez 'Newsletter' si nécessaire
  ];
void _signOut() async {
  try {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    context.go('/');
  } catch (e) {
    print("Erreur de déconnexion : $e");  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text("Page d'administration")),
      drawer: AdminDrawer(
        sectionNames: sectionNames,
        onSectionChanged: (sectionIndex) {
          setState(() {
            activePageIndex = sectionIndex;
          });
        },
      ),
      body: page[activePageIndex], // Affiche la page active ici
    );
  }
}

class AdminDrawer extends StatelessWidget {
  final List<String> sectionNames;
  final Function(int) onSectionChanged;

  const AdminDrawer({
    Key? key,
    required this.sectionNames,
    required this.onSectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final FirebaseAuth auth = FirebaseAuth.instance;

    void signOut() async {
  try {
    await auth.signOut();
    context.go('/');
  } catch (e) {
    print("Erreur de déconnexion : $e");
  }
}
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              "Menu d'administration",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          for (int i = 0; i < sectionNames.length; i++)
            buildDrawerItem(sectionNames[i], i),
          ListTile(
            title: const Text("Déconnexion"),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              // Gérez la déconnexion ici
              signOut();
            },
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerItem(String title, int index) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: index == index ? Colors.green : Colors.black,
        ),
      ),
      onTap: () {
        onSectionChanged(index);
      },
    );
  }
  
}