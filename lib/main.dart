import 'package:flutter/material.dart';
import 'package:hackjnu_dumper/database/Apis.dart';
import 'package:hackjnu_dumper/shovel.dart';
import 'package:hackjnu_dumper/dumperselect.dart';
import 'package:hackjnu_dumper/map_provider.dart';
import 'package:hackjnu_dumper/selectShovel.dart';
import 'package:hackjnu_dumper/startPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MapProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;
  ApiService apiService = ApiService(); 
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Dumper(),
    );
  }
}

