import 'package:acote/Home/HomeVM.dart';
import 'package:acote/Home/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => HomeVM()..fetchUsers(),
        child: MaterialApp(
          title: 'GitHub Users',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeView(),
        ));
  }
}
