import 'package:doni_pizza_admin/business_logic/cubit/tab_cubit.dart';
import 'package:doni_pizza_admin/presentation/ui/tab_box/tab_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Log Out',
            style: TextStyle(
                fontFamily: 'Sora', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: ShapeBorder.lerp(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            0.5,
                          ),
                          title: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sora',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: const Text('Admin profilidan chiqmoqchimisiz?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Yo\'q',
                                style: TextStyle(color: Colors.black, fontFamily: 'Sora'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<TabCubit>().changeTab(0);
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => const TabBox()));
                              },
                              child: const Text(
                                'Ha',
                                style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      CupertinoIcons.location_slash_fill,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width / 3,
                    ),
                  ))),
        ],
      ),
    );
  }
}
