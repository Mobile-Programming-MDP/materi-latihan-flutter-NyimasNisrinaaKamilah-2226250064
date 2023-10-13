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
            theme: ThemeData(primarySwatch: Colors.blue),
            home: firstScreen()
        );
    }
}

    class firstScreen extends StatelessWidget {
        const firstScreen({super.key});

        @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text("Nyimas Nisrinaa Kamilah"),
            ),
            body: const Center(
                child: Text("Hallo Nyimas"),
            ),
        );
    }
}