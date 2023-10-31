// ignore_for_file: library_private_types_in_public_api

import 'package:doni_pizza_admin/presentation/ui/delivered/delivered.dart';
import 'package:doni_pizza_admin/presentation/ui/delivering/delivering.dart';
import 'package:doni_pizza_admin/presentation/ui/preparing/preparing.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/tab_cubit.dart';
import '../home/home_screen.dart';

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
      body: BlocBuilder<TabCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: context
                .watch<TabCubit>()
                .state,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Colors.grey[300],
        currentIndex: context
            .watch<TabCubit>()
            .state,
        onTap: context
            .read<TabCubit>()
            .changeTab,
        unselectedItemColor: Colors.grey,
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Badge(
              label: Text('3'),
              child: Icon(Icons.receipt_long_outlined),
            ),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Badge(
              label: Text('1'),
              child: Icon(Icons.delivery_dining),
            ),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.check_circle_outline_sharp),
            selectedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}