import 'package:doni_pizza_admin/presentation/ui/tab_box/tab_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'business_logic/cubit/tab_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        home: const TabBox(),
      ),
    );
  }
}
