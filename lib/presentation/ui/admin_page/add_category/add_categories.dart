import 'dart:io';

import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:doni_pizza_admin/presentation/utils/helpers/uid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/business_logic/cubit/category_cubit/category_cubit.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/dialog_gallery_camera.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  AddCategoryState createState() => AddCategoryState();
}

class AddCategoryState extends State<AddCategory> {
  final TextEditingController categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Qo\'shish',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    showCameraAndGalleryDialog(context, (imagePath) {
                      if (imagePath != null) {
                        setState(() {
                          selectedImagePath = imagePath;
                        });
                      }
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4.2,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: selectedImagePath == null ? Colors.grey.shade400 : Colors.black,
                    ),
                    child: selectedImagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              File(selectedImagePath!),
                              fit: BoxFit.scaleDown,
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 80.0),
                              child: Icon(
                                CupertinoIcons.camera,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GlobalTextField(
                  controller: categoryController,
                  hintText: 'Categoriyaning nomi',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Categoriyaning nomini kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && selectedImagePath != null) {
                      final newCategory = CategoryModel(
                        id: UidGenerator.generateUID(),
                        name: categoryController.text,
                        imageUrl: selectedImagePath ?? '',
                      );
                      // print(selectedImagePath);
                      BlocProvider.of<CategoryCubit>(context).addCategory(category: newCategory, image: File(selectedImagePath!));
                      Navigator.pop(context);
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Qo\'shish',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
