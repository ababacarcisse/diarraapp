import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/providers/auth_notification.dart';
import 'CreateProductPage.dart';
import 'DashboardPage.dart';
import 'commandPage.dart';
import 'createCategoryPage.dart';

import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context,) {


    int activePageIndex = 0; // Index de la page active
    List<Widget> page = [
      const DashboardPage(),
      const CreateCategoryPage(),
      const CreateProductPage(),
      const CommandPage(),
      // NewletterPage(),
    ];

    List<String> sectionNames = [
      'Tableau de bord',
      'Créer une Catégorie',
      'Créer un produit',
      'Commandes',
    ];

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
          Consumer(
            builder: (context, ref, child) {
              return ListTile(
                title: const Text("Déconnexion"),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                                },
              );
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
