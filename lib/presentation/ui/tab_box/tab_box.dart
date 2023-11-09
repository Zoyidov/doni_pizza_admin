// ignore_for_file: library_private_types_in_public_api

import 'package:doni_pizza_admin/presentation/ui/delivered/delivered.dart';
import 'package:doni_pizza_admin/presentation/ui/delivering/delivering.dart';
import 'package:doni_pizza_admin/presentation/ui/preparing/preparing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'package:doni_pizza_admin/business_logic/cubit/tab_cubit.dart';
import 'package:doni_pizza_admin/presentation/ui/home/home_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  _TabBoxState createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> pages = [
    const HomeScreen(),
    const PreparingScreen(),
    const DeliveringScreen(),
    const DeliveredScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: context
              .watch<TabCubit>()
              .state,
          children: pages,
        ),
        // body: PageView(
        //   pageSnapping: ,
        //   children: pages,
        //   onPageChanged: context.read<TabCubit>().changeTab,
        // ),
        bottomNavigationBar: StylishBottomBar(
          option: BubbleBarOptions(
            opacity: 0.5,
          ),
          items: [
            BottomBarItem(
              icon: const Icon(CupertinoIcons.doc_on_doc),
              title: const Text(
                'Buyurtmalar',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              selectedIcon: const Icon(
                CupertinoIcons.doc_on_doc_fill,
                color: Colors.white,
              ),
            ),
            BottomBarItem(
              icon: const Icon(Icons.watch_later_outlined),
              title: const Text(
                'Tayyorlanmoqda',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue[900],
              selectedIcon: const Icon(
                Icons.watch_later,
                color: Colors.white,
              ),
            ),
            BottomBarItem(
              icon: const Icon(Icons.directions_run),
              title: const Text(
                'Yetkazilmoqda',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.amber[900],
              selectedIcon: const Icon(
                Icons.directions_bike,
                color: Colors.white,
              ),
            ),
            BottomBarItem(
              icon: const Icon(Icons.dining_outlined),
              title: const Text(
                'Yetkazildi',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green[900],
              selectedIcon: const Icon(
                Icons.dining,
                color: Colors.white,
              ),
            ),
          ],
          hasNotch: true,
          currentIndex: context.watch<TabCubit>().state,
          onTap: context.read<TabCubit>().changeTab,
        ));
  }
}
