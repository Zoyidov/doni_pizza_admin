import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class DetailScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String location;
  final String description;

  DetailScreen({required this.name, required this.phoneNumber, required this.location, required this.description});

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          '$location',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            _makePhoneCall(phoneNumber);
          }, icon: Icon(Icons.phone,color: Colors.green,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  Text('Phone: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  InkWell(
                    onTap: () {
                      _makePhoneCall(phoneNumber);
                    },
                    child: Text(
                      '$phoneNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Text('Location: $location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Description: $description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomTapAnimation(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.green),
                        child: Center(
                          child: Text('Qabul qilish',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Sora'),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    ZoomTapAnimation(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red),
                        child: Center(
                          child: Text('Bekor qilish',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Sora'),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
