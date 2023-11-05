import 'dart:io';

import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widgets/dialog_gallery_camera.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.category});
  final String category;

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.category);
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
        title: Text(
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
          physics: BouncingScrollPhysics(),
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
              SizedBox(height: 20.0),
              GlobalTextField(
                controller: categoryController,
                hintText: 'Categoriyaning yangi nomi',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              SizedBox(
                height: 20.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 2,
                    )),
                onPressed: () {},
                child: Center(
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
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
