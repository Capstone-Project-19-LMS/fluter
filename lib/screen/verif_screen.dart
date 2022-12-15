import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/screen/registscreen.dart';
import 'package:kelompok19lmsproject/widgets/logowidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({super.key});

  @override
  State<VerifScreen> createState() => _VerifScreen();
}

class _VerifScreen extends State<VerifScreen> {
  late String code, email;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  SharedPreferences? prefs;

  TextEditingController _codeTextController = TextEditingController();
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

  void processVerifikasiRequest(code, email) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await tryVerif(code, email).timeout(
      const Duration(seconds: 8),
    );

    // print(apiResponse.body);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      if (kDebugMode) {
        print(apiResponse.body);
      }
      EasyLoading.showSuccess(
        'Verifikasi Berhasil!',
        maskType: EasyLoadingMaskType.custom,
      );
      Timer(
        const Duration(milliseconds: 1000),
        () {
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
                    const Icon(Icons.email,
                        size: 100, color: Colors.deepOrange),
                    const Text(
                      'Cek Email Yak!',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Pendaftaran Kamu Berhasil. Silahkan Cek \nemail kamu untuk verifikasi akun ya!',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              );
            },
          );
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pop(context);
            },
          );

          setState(
            () {
              _isLoading = false;
            },
          );
        },
      );
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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegistScreen()));
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/image/verif.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verifikasi OTP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Cek email anda untuk  mengetahui kode OTP",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
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
                          // validator: (emailValue) {
                          //   if (emailValue!.isEmpty) {
                          //     return 'Silahkan Masukkan Email Anda';
                          //   }
                          //   email = emailValue;
                          //   return null;
                          // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _codeTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          labelText: 'Kode Verifikasi',
                          hintText: 'Masukan Kode',
                        ),
                        // validator: (codeValue) {
                        //   if (codeValue!.isEmpty) {
                        //     return 'Silahkan Masukkan Kode Anda';
                        //   }
                        //   code = codeValue;
                        //   return null;
                        // },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      processVerifikasiRequest(_emailTextController.text.toString(),
                          _codeTextController.text.toString());
                      setState(() {
                        _isLoading = true;
                      });
                    } else {
                      _showAlertDialog("Pastikan Email atau Kode Benar");
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Verifikasi',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _textFieldOTP({required bool first, last}) {
  //   return Container(
  //     height: 70,
  //     child: AspectRatio(
  //       aspectRatio: 1.0,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: (value) {
  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: const InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(width: 2, color: Colors.black12),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(width: 2, color: Colors.yellow),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 812,
//       width: double.infinity,
//       padding: const EdgeInsets.all(8),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             logoWidget("assets/image/verif.png"),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Verifikasi OTP",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text("Cek email anda untuk"),
//             const Text("mengetahui kode OTP"),
//             const SizedBox(
//               height: 50,
//             ),
//             _textFieldOTP(first: true, last: false),
//             _textFieldOTP(first: true, last: false),
//             // TextFormField(
//             //   keyboardType: TextInputType.number,
//             //   style: const TextStyle(
//             //     fontSize: 18,
//             //     fontWeight: FontWeight.bold,
//             //   ),
//             //   decoration: InputDecoration(
//             //     enabledBorder: OutlineInputBorder(
//             //       borderSide: const BorderSide(color: Colors.black12),
//             //       borderRadius: BorderRadius.circular(10),
//             //     ),
//             //     focusedBorder: OutlineInputBorder(
//             //       borderSide: const BorderSide(color: Colors.black12),
//             //       borderRadius: BorderRadius.circular(10),
//             //     ),
//             //   ),
//             // onChanged: (value) {
//             //   if (value.length == 1) {
//             //     FocusScope.of(context).nextFocus();
//             //   }
//             // },
//             // onSaved: (pin1) {},
//             // decoration: InputDecoration(hintText: "0"),
//             // style: Theme.of(context).textTheme.headline6,
//             // keyboardType: TextInputType.number,
//             // textAlign: TextAlign.center,
//             // inputFormatters: [
//             //   LengthLimitingTextInputFormatter(1),
//             //   FilteringTextInputFormatter.digitsOnly,
//             // ],
//             // ),
//             const SizedBox(
//               height: 30,
//             ),
//             // TextFormField(
//             //   decoration: const InputDecoration(
//             //     border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
//             //     labelText: 'Kode Verifikasi',
//             //     hintText: 'Masukan Kode',
//             //   ),
//             //   validator: (codeValue) {
//             //     if (codeValue!.isEmpty) {
//             //       return 'Silahkan Masukkan Kode Verifikasi Anda';
//             //     }
//             //     code = codeValue;
//             //     return null;
//             //   },
//             // ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 40,
//               margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(90)),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     processVerifikasiRequest(code, customer_id);
//                   }
//                 },
//                 child: const Text('Verifikasi'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _textFieldOTP({required bool first, last}) {
//     return Container(
//         height: 85,
//         child: AspectRatio(
//           aspectRatio: 1.0,
//           child: TextField(
//             autofocus: true,
//             onChanged: (value) {
//               // if (value.length = 1 && last = false) {
//               //   FocusScope.of(context).nextFocus();
//               // }
//               // if(value.length = 1 && first = false){
//               //   FocusScope.of(context).previousFocus();
//               // }
//             },
//             showCursor: false,
//             readOnly: false,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             keyboardType: TextInputType.number,
//             maxLines: 1,
//             decoration: InputDecoration(
//               counter: Offstage(),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Colors.yellow),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ));
//   }
// }