import 'dart:io';

import 'package:doni_pizza_admin/business_logic/model/promotion_model.dart';
import 'package:doni_pizza_admin/business_logic/promotion_bloc/promotion_bloc.dart';
import 'package:doni_pizza_admin/presentation/utils/helpers/uid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/presentation/ui/widgets/dialog_gallery_camera.dart';

class AddNewPromotion extends StatefulWidget {
  const AddNewPromotion({super.key});

  @override
  State<AddNewPromotion> createState() => _AddNewPromotionState();
}

class _AddNewPromotionState extends State<AddNewPromotion> {
  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    final newPromotion =
        Promotion(id: UidGenerator.generateUID(), imageUrl: selectedImagePath ?? '');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Reklama Banneri',
          style: TextStyle(
              fontFamily: 'Sora', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
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
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (selectedImagePath != null) {
            context.read<PromotionBloc>().add(AddPromotion(newPromotion, File(selectedImagePath!)));
            Navigator.pop(context);
          }
          else{
            Fluttertoast.showToast(
              msg: 'Rasm tanlang',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }
        },
        heroTag: 'addPromotion',
        child: const Icon(Icons.send),
      ),
    );
  }
}
