import 'package:acote/Home/HomeVM.dart';
import 'package:acote/Home/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserVM()..fetchUsers(),
      child: MaterialApp(
        title: 'GitHub Users',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      ),
    );
  }
}
