import 'dart:io';

import 'package:doni_pizza_admin/business_logic/cubit/category_cubit/category_cubit.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/food_bloc.dart';
import 'package:doni_pizza_admin/business_logic/model/food_model.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:doni_pizza_admin/presentation/utils/helpers/uid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/presentation/ui/widgets/dialog_gallery_camera.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              fontFamily: 'Sora', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
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
                const SizedBox(
                  height: 20.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning nomi',
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot nomini kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning ma\'lumoti',
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot ma\'lumotini kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning narxi',
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot narxini kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        width: 2,
                      )),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final food = FoodItem(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        price: int.parse(_priceController.text).toDouble(),
                        imageUrl: '',
                        id: UidGenerator.generateUID(),
                        category: context.read<CategoryCubit>().state[0],
                      );
                      context
                          .read<FoodBlocRemote>()
                          .add(CreateFoodItem(food, File(selectedImagePath!)));

                      // foodBloc.add(AddFoodEvent(food));
                      // Navigator.pop(context, {
                      //   'name': _nameController.text,
                      //   'description': _descriptionController.text,
                      //   'price': _priceController.text
                      // });
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Qo\'shish',
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
