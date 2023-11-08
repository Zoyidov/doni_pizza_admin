import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/food_bloc.dart';
import 'package:doni_pizza_admin/business_logic/model/food_model.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/dialog_gallery_camera.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:doni_pizza_admin/presentation/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EditProduct extends StatefulWidget {
  final FoodItem foodItem;

  const EditProduct({super.key, required this.foodItem,});

  @override
  EditProductState createState() => EditProductState();
}

class EditProductState extends State<EditProduct> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.foodItem.name);
    _descriptionController = TextEditingController(text: widget.foodItem.description);
    _priceController = TextEditingController(text: widget.foodItem.price.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    // final updateCategory = CategoryModel(
    //   name: _nameController.text,
    //   imageUrl: selectedImagePath ?? widget.foodItem.imageUrl,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Yangilash',
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 4.2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: selectedImagePath == null
                        ? Colors.grey.shade400
                        : Colors.black,
                  ),
                  child: selectedImagePath == null
                      ? CachedNetworkImage(imageUrl: widget.foodItem.imageUrl)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      File(selectedImagePath!),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppImages.log);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              GlobalTextField(
                controller: _nameController,
                hintText: 'Maxsulotning yangi nomi',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              const SizedBox(
                height: 10.0,
              ),
              GlobalTextField(
                controller: _descriptionController,
                hintText: 'Maxsulotning yangi ma\'lumoti',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              const SizedBox(
                height: 10.0,
              ),
              GlobalTextField(
                controller: _priceController,
                hintText: 'Maxsulotning yangi narxi',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              const SizedBox(height: 20,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      width: 2,
                    )),
                onPressed: () {
                  widget.foodItem.copyWith(
                    name: _nameController.text,
                    description: _descriptionController.text,
                    price: double.parse(_priceController.text),
                  );
                  context.read<FoodBlocRemote>().add(
                      UpdateFoodItem(
                        widget.foodItem.id!,
                        widget.foodItem,
                        (selectedImagePath != null) ? File(
                            selectedImagePath!) : null,


                      )
                  );
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
