import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/business_logic/cubit/category_cubit/category_cubit.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/dialog_gallery_camera.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.category});

  final CategoryModel category;

  @override
  EditCategoryState createState() => EditCategoryState();
}

class EditCategoryState extends State<EditCategory> {
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.category.name);
  }

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
          'Yangilash',
          style: TextStyle(
              fontFamily: 'Sora', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.category.imageUrl,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlobalTextField(
                controller: categoryController,
                hintText: 'Categoriyaning yangi nomi',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              const SizedBox(
                height: 20.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      width: 2,
                    )),
                onPressed: () {
                  final name = categoryController.text;
                  if (categoryController.text.isNotEmpty) {
                    context.read<CategoryCubit>().updateCategory(
                        widget.category.copyWith(name: name),
                        selectedImagePath != null ? File(selectedImagePath!) : null);
                    if (kDebugMode) {
                      print('ok');
                    }
                    Navigator.pop(context);
                  } else {
                    if (kDebugMode) {
                      print(selectedImagePath);
                    }
                  }
                },
                child: const Center(
                  child: Text(
                    'Yangilash',
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
    );
  }
}
