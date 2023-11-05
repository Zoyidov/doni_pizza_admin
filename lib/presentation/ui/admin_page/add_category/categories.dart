import 'package:doni_pizza_admin/business_logic/cubit/category_cubit/category_cubit.dart';
import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_category/add_categories.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/edit/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/repositories/category_repo.dart';
import '../../../utils/icons.dart';
import '../../widgets/global dialog.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

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
      body: BlocBuilder<CategoryCubit, List<CategoryModel>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final category = state[index];
              return ListTile(
                title: Text(category.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Sora')),
                leading: Image.asset(
                  category.imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.log),
                    );
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategory(category: category.name,)));
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
                      icon: Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                ),
              );
            },
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
