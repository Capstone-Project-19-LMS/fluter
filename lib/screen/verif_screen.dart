import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/widgets/logowidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({super.key});

  @override
  State<VerifScreen> createState() => _VerifScreen();
}

class _VerifScreen extends State<VerifScreen> {
  late String code;
  late String customer_id;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  SharedPreferences? prefs;

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
                    text: 'ERROR VERIFIKASI',
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

  void processVerifikasiRequest(code, customer_id) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await tryVerif(code, customer_id).timeout(
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
    return Container(
      height: 812,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            logoWidget("assets/image/logo.png"),
            const Text("Verifikasi"),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
                labelText: 'Kode Verifikasi',
                hintText: 'Masukan Kode',
              ),
              validator: (codeValue) {
                if (codeValue!.isEmpty) {
                  return 'Silahkan Masukkan Kode Verifikasi Anda';
                }
                code = codeValue;
                return null;
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    processVerifikasiRequest(code, customer_id);
                  }
                },
                child: const Text('Verifikasi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
