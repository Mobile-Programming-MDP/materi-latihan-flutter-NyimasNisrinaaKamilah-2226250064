import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signInScreen extends StatefulWidget {
  signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  //TOD: 1 Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errortext = ' ';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  
  void _signIn() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedUsername = prefs.getString('username') ?? '';
    final String savedPassword = prefs.getString('password') ?? '';
    final String enteredUsername = _usernameController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    if(enteredUsername.isEmpty || enteredPassword.isEmpty)
    {
      setState(() {
        _errortext = 'Nama pengguna dan kata sandi harus diisi.';
      });
      return;
    }

     if(savedUsername.isEmpty || savedPassword.isEmpty)
    {
      setState(() {
        _errortext = 'Pengguna belum terdaftar. Silahkan daftar terlebih dahulu.';
      });
      return;
    }

    if(enteredUsername == savedUsername && enteredPassword == savedPassword)
    {
      setState(() {
        _errortext = '';
        _isSignedIn = true;
        prefs.setBool('isSignedin', true);
      });

      //pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
       });

      //Sign in berhasil navigasikan ke layar utama
      WidgetsBinding.instance.addPostFrameCallback((_) { 
        Navigator.pushReplacementNamed(context, '/');
      });
    }
    else
    {
      setState(() {
        _errortext = 'Nama pengguna atau Kata sandi salah.';
      });
    }
  }

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
              //TODO :6 Pasang TextForm Field kata sandi
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
                    ..onTap = () {
                      Navigator.pushNamed(context, '/signup');
                    },
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