import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs (
    SharedPreferences sharedPreferences,
  ) async {
    //final sharedPreferences = await sharedPreferences;
    final encryptedUsername = sharedPreferences.getString('username') ?? '';
    final encryptedPassword = sharedPreferences.getString('password') ?? '';
    final keyString = sharedPreferences.getString('key') ?? '';
    final ivString = sharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv :iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv :iv);

    //mengembalikan data terdeskripsi
    return {'username' : decryptedUsername, 'password' : decryptedPassword};
  }
  
  void _signIn() async
  {
    try  {
      final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
      final String username = _usernameController.text;
      final String password = _passwordController.text;
      print('Sign In attempt');

      if(username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await _retrieveAndDecryptDataFromPrefs(prefs);
        if(data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];

          if(username == decryptedUsername && password == decryptedPassword ) {
            _errortext = '';
            _isSignedIn = true;
            prefs.setBool('isSignedIn', true);
            //Pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            //Sign in berhasil, navigasikan ke layar utama
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
            print('Sign Insucceeded');
          } else {
            print('Username or Password is incorrect');
          }
        } else {
          print('No stored credentials found');
        }
      } else {
        print('Username and password cannot be empty');
        //Ta,bahkan pesan untuk kasus ketika username atau password kosong
      }
    } catch (e) {
      print('An error occurred: $e');
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