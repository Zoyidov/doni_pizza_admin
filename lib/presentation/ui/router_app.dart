import 'package:doni_pizza_admin/business_logic/order_bloc/order_remote_bloc.dart';
import 'package:doni_pizza_admin/presentation/ui/auth/auth_screen.dart';
import 'package:doni_pizza_admin/presentation/ui/tab_box/tab_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doni_pizza_admin/business_logic/cubit/auth_cubit.dart';

class RouterApp extends StatelessWidget {
  const RouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state == AuthState.unauthenticated) {
          return const AuthScreen();
        } else {
          return const TabBox();
        }
      },
      listener: (BuildContext context, AuthState state) {
        if (state == AuthState.unauthenticated) {
          context.read<OrderRemoteBloc>().init();
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RouterApp(),
          ),
          (route) => false,
        );
      },
    );
  }
}
