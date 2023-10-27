import 'package:flutter/material.dart';

class signInScreen extends StatefulWidget {
  signInScreen({super.key});
  
  @override
  State<signInScreen>createState()=> _signInScreenState();
}

class _signInScreenState extends State<signInScreen {
  //TOD: 1 Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errortext = ' ';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //TODo: 2 pasang AppBar
      appBar: AppBar(title: Text('Sign in'),),
      //TODO: 3 Pasang body
      body: Center(
        child: SingleChildScrollView (
          child: Padding(
            padding: const EdgeInsets.all(16),
          child: Form(
          child: Column(
            //TODO: 4 Atur mainAxisAligmnet dan CrossAxisAlignment
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //TODo :5 Pasang TextFormFIeld Nama pengguna
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Nama Pengguna",
                  border: OutlineInputBorder(),
                ),
              ),
              //TODO :6 Pasang TextFormField kata sandi
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Kata Sandi",
                  errorText: _errortext.isNotEmpty ? _errortext : null,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _obscurePassword = !_obscurePassword;
                    }, 
                    icon: Icon( _obscurePassword ? Icons.visibility_off : Icons.visibility,),),
                ),
                obscureText: _obscurePassword,
              ),
              //TODo :7 pasang elevatedButton Sign in
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {}, 
                child: Text('Sign In')),
              //TODO: 8 Pasang TextButton Sign UP
              SizedBox(height: 10),
              RichText(text: TextSpan(
                text: 'Belum punya akun ?',
                style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Daftra di sini',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 16
                    ),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () {},
                  )
                ]
              ),
              )
            ],
        ),
        ),
      ),
      ),
      ),
    );
  }
}