import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/loginscreen.dart';
import 'package:kelompok19lmsproject/screen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/profilewidget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool iChecked = false;
  bool visibilityPass = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _secureText = true;
  late String token;
  bool obsecureText = true;
  SharedPreferences? prefs;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _tokenTextController = TextEditingController();

  void processLogoutRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await tryLogout(prefs.getString("key")!);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      // if (data['message'] == 'logout success') {
      //   prefs.setString('key', data['token']);
      //   if (kDebugMode) {
      //     print('data : ${data['token']}');
      //   }
      EasyLoading.showSuccess(
        'Logout Berhasil!',
        maskType: EasyLoadingMaskType.custom,
      );
      Timer(const Duration(milliseconds: 1000), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => LoginScreen(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  maxRadius: 30,
                  minRadius: 30,
                  backgroundColor: Colors.yellow,
                  backgroundImage: AssetImage("assets/image/profil.png"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Hai , Maharani",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                        "Mentee",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Pengaturan Akun",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const ProfileWidget(
            title: 'Ubah Profil',
          ),
          const ProfileWidget(
            title: 'Ubah Bahasa',
          ),
          const ProfileWidget(
            title: 'Unduhan',
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Lainnya",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const ProfileWidget(
            title: 'Pusat Bantuan',
          ),
          const ProfileWidget(
            title: 'Kebijakan Privasi',
          ),
          const ProfileWidget(
            title: 'Ketentuan Pengguna',
          ),
          const ProfileWidget(
            title: 'Laporkan Masalah',
          ),
          const ProfileWidget(
            title: 'Versi Aplikasi',
          ),
          const ProfileWidget(
            title: 'Tentang Kami',
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: InkWell(
              onTap: () {
                processLogoutRequest();
                // if (_formKey.currentState!.validate()) {
                //   processLogoutRequest(token.toString());
                // } else {
                //   _showAlertDialog("hehe");
                // }
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                      size: 18,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
