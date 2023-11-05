import 'dart:io';

import 'package:doni_pizza_admin/business_logic/food_bloc/state_bloc.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widgets/dialog_gallery_camera.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
    final foodBloc = context.read<FoodBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Qo\'shish',
          style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                    height: MediaQuery.of(context).size.height/4.2,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: selectedImagePath == null
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                    child: selectedImagePath != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        File(selectedImagePath!),
                        fit: BoxFit.scaleDown,
                      ),
                    )
                        : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80.0),
                        child: Icon(
                          CupertinoIcons.camera,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning nomi',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot nomini kiriting';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning ma\'lumoti',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot ma\'lumotini kiriting';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                GlobalTextField(
                  hintText: 'Maxsulotning narxi',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  caption: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot narxini kiriting';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50,),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(
                        width: 2,
                      )),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // foodBloc.add(AddFoodEvent(food));
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'description': _descriptionController.text,
                        'price': _priceController.text
                    });
                    }
                  },
                  child: Center(
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
