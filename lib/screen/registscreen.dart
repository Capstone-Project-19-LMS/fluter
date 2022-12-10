import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/widgets/logowidget.dart';
// import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../api/api.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({Key? key}) : super(key: key);

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  bool iChecked = false;
  bool visibilitypass = false;
  SharedPreferences? prefs;
  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPass(String input) =>
      RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(input);
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _secureText = true;
  late String email, name, password;
  bool obsecureText = true;

  // TextEditingController _passwordTextController = TextEditingController();
  // TextEditingController _emailTextController = TextEditingController();
  // TextEditingController _nameTextController = TextEditingController();
  // String response = "";

  void showPassword() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

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
                    text: 'ERROR REGISTRASI',
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

  // @override
  // void dispose() {
  //   _emailTextController.dispose();
  //   _passwordTextController.dispose();
  //   _nameTextController.dispose();
  //   super.dispose();
  // }

  void processRegisterRequest(name, email, password) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await tryRegister(name, email, password).timeout(
      const Duration(seconds: 8),
    );

    // print(apiResponse.body);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      if (kDebugMode) {
        print(apiResponse.body);
      }
      if (data['message'] == 'success create user') {
        EasyLoading.showSuccess(
          'Registrasi Berhasil!',
          maskType: EasyLoadingMaskType.custom,
        );
        Timer(const Duration(milliseconds: 1000), () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => const LoginScreen(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).copyWith().size.height * 0.35,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.email, size: 100, color: Colors.deepOrange),
                      Text(
                        'Cek Email Yak!',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pendaftaran Kamu Berhasil. Silahkan Cek \nemail kamu untuk verifikasi akun ya!',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              });
          Timer(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });

          setState(() {
            _isLoading = false;
          });
        });
      } else {
        _showAlertDialog(data['message']);
      }
    } else if (apiResponse.statusCode == 401) {
      _showAlertDialog("Form Anda Isi Salah ");
    } else {
      _showAlertDialog(
          "Pastikan Form Anda Terisi Dengan Benar Atau Email Anda Sudah Terdaftar :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 251, 220, 13),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      logoWidget("assets/image/logo.png"),
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // controller: _nameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          labelText: 'Nama Lengkap',
                          hintText: 'Masukan Lengkap',
                        ),
                        validator: (nameValue) {
                          if (nameValue!.isEmpty) {
                            return 'Silahkan Masukkan Nama Lengkap Anda';
                          }
                          name = nameValue;
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // controller: _emailTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          labelText: 'Nama Email',
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
                        // controller: _passwordTextController,
                        obscureText: !visibilitypass,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          labelText: 'Kata Sandi',
                          hintText: 'Masukan Kata Sandi',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibilitypass = !visibilitypass;
                                });
                              },
                              icon: visibilitypass
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                        validator: (passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return 'Silahkan Masukkan Nama Lengkap Anda';
                          }
                          password = passwordValue;
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   // controller: _passwordTextController,
                      //   obscureText: !visibilitypass,
                      //   decoration: InputDecoration(
                      //     border: const OutlineInputBorder(
                      //         borderSide: BorderSide(width: 2.0)),
                      //     labelText: 'Konfirmasi Kata Sandi',
                      //     hintText: 'Masukan Kata Sandi',
                      //     suffixIcon: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             visibilitypass = !visibilitypass;
                      //           });
                      //         },
                      //         icon: visibilitypass
                      //             ? const Icon(Icons.visibility)
                      //             : const Icon(Icons.visibility_off)),
                      //   ),
                      //   validator: (passwordValue) {
                      //     if (passwordValue!.isEmpty) {
                      //       return 'Silahkan Masukkan Nama Lengkap Anda';
                      //     }
                      //     password = passwordValue;
                      //     return null;
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: iChecked,
                            onChanged: (value) {
                              iChecked = !iChecked;
                              setState(() {});
                            },
                          ),
                          Expanded(
                            child: const Text(
                              "Saya telah membaca dan setuju dengan persyaratan layanan dan polisi privasi kami",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              processRegisterRequest(name, email, password);
                            }
                          },
                          child: Text('Daftar'),
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
      ),
    );
  }

  // _post() async {
  //   Map<String, dynamic> data = {
  //     "name": _nameTextController.text,
  //     "email": _emailTextController.text,
  //     "Password": _passwordTextController.text,
  //   };
  //   try {
  //     Response response =
  //         await Dio().post("http://13.213.47.36/customer/register", data: data);
  //     setState(() {
  //       this.response = response.data.toString();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<Map<String, dynamic>> _parseAndDecode(String response) async {
  //   return json.decode(response);
  // }
}
