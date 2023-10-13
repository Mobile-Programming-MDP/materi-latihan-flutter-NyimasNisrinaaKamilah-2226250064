import 'package:flutter/material.dart';

void main(){
    runApp(const myApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build (BuildContext context){
        return MaterialApp(
            title: "Hallo Widget",
            theme: ThemeData(primarySwatch: colors.pink),
            home: Scaffold(
                appBar: appBar(
                title: const text("Nyimas Nisrinaa Kamilah"),
            ), //AppBar
            body: const Center(
                child: Text("Hallo Nyimas Nisrinaa Kamilah"),
            ), //center
        )); //Scaffold//MaterialApp
    }
}