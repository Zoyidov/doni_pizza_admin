import 'package:doni_pizza_admin/presentation/ui/admin_page/add_promotion/add_promotion.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global%20dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Promotions extends StatefulWidget {
  const Promotions({super.key});

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Reklama Banneri',
            style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ZoomTapAnimation(
            onLongTap: () {
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
            child: Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://h5p.org/sites/default/files/h5p/content/1209180/images/file-6113d5f8845dc.jpeg'),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addPromotion',
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPromotion()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
