import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/homescreen.dart';
import 'package:kelompok19lmsproject/screen/index.dart';
import 'package:kelompok19lmsproject/screen/registscreen.dart';
import 'package:kelompok19lmsproject/widgets/logowidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool iChecked = false;
  bool visibilityPass = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _secureText = true;
  late String email, name, password;
  bool obsecureText = true;
  SharedPreferences? prefs;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  void _showAlertDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text.rich(
            TextSpan(
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Colors.red,
                ),
                children: [
                  TextSpan(
                    text: 'ERROR LOGIN',
                  ),
                  TextSpan(
                    text: '  ',
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                  ),
                ]),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 1,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void processLoginRequest(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await tryLogin(email, password).timeout(
      const Duration(seconds: 8),
    );

    // print(apiResponse.body);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      if (data['message'] == 'success login') {
        prefs.setString('key', data['user']['token']);
        if (kDebugMode) {
          print('data : ${data['user']['token']}');
        }
        EasyLoading.showSuccess(
          'Login Berhasil!',
          maskType: EasyLoadingMaskType.custom,
        );
        Timer(const Duration(milliseconds: 1000), () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => const Index(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        _showAlertDialog(data['message']);
      }
    } else if (apiResponse.statusCode == 401) {
      _showAlertDialog(
          "Email/Password Salah \n\nPastikan Sudah Lakukan Verfikasi Email");
    } else {
      _showAlertDialog("Pastikan Password atau Email Anda Benar :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(20),
        // width: double.infinity,
        // height: double.infinity,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.center,
        //         colors: [Color.fromARGB(255, 255, 230, 0), Colors.white])),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            logoWidget("assets/image/logo.png"),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topRight,
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0)),
                        labelText: 'Email',
                        hintText: 'Masukan Email',
                      ),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          return 'Silahkan Masukkan Email Anda';
                        }
                        email = emailValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      obscureText: !visibilityPass,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0)),
                        labelText: 'Password',
                        hintText: 'Masukan Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visibilityPass = !visibilityPass;
                              });
                            },
                            icon: visibilityPass
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                      ),
                      validator: (passwordValue) {
                        if (passwordValue!.isEmpty) {
                          return 'Silahkan Masukkan Email Anda';
                        }
                        password = passwordValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // const Text(
                        //   "Simpan Kata Sandi",
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        // Checkbox(
                        //   value: iChecked,
                        //   onChanged: (value) {
                        //     iChecked = !iChecked;
                        //     setState(() {});
                        //   },
                        // ),
                        // const SizedBox(
                        //   width: 45,
                        // ),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Lupa kata sandi?'))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(

                        onPressed: () async{
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn',true);
                          if(_formKey.currentState!.validate()){
                            processLoginRequest(_emailTextController.text.toString(), _passwordTextController.text.toString());
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            processLoginRequest(
                                _emailTextController.text.toString(),
                                _passwordTextController.text.toString());

                            setState(() {
                              _isLoading = true;
                            });
                          } else {
                            _showAlertDialog(
                                "Pastikan Email atau Password Benar");
                          }
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Text('Masuk'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun?",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(context, '/register');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistScreen()));
                          },
                          child: Text('Daftar'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
