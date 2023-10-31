import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../widgets/dialog_gallery_camera.dart';

class AddPromotion extends StatefulWidget {
  const AddPromotion({super.key});

  @override
  State<AddPromotion> createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Reklama Banneri',
          style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
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
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
        },
        child: Icon(Icons.send),
        heroTag: 'addPromotion',
      ),
    );
  }
}
