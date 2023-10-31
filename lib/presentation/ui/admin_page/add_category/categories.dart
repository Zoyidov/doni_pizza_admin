import 'package:doni_pizza_admin/presentation/ui/admin_page/add_category/add_categories.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/edit/edit_category.dart';
import 'package:flutter/material.dart';

import '../../widgets/global dialog.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<String> categories = [
    'Pizza ',
    'Lavash ',
    'Burger',
    'Ichimliklar',
    'Xagi',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Categoriyalar', style: TextStyle(fontFamily: 'Sora', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){},
            title: Text(categories[index]),
            leading: Icon(Icons.local_pizza,color: Colors.blueAccent,),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategory()));
                  },
                  icon: Icon(Icons.edit,color: Colors.black,),
                ),
                IconButton(
                  onPressed: () {
                    GlobalDialog.show(
                      context: context,
                      title: 'O\'chirish',
                      message: 'Haqiqatdan ham o\'chirmoqchimisiz?',
                      buttonYes: 'Ha',
                      buttonNo: 'Yo\'q',
                      onYesPressed: () {},
                      onNoPressed: () {},
                    );
                  },
                  icon: Icon(Icons.delete,color: Colors.red,),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addCategory',
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
