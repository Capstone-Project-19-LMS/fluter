import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/profilewidget.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                CircleAvatar(
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
                    children: [
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
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Pengaturan Akun",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ProfileWidget(
            title: 'Ubah Profil',
          ),
          ProfileWidget(
            title: 'Ubah Bahasa',
          ),
          ProfileWidget(
            title: 'Unduhan',
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Lainnya",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ProfileWidget(
            title: 'Pusat Bantuan',
          ),
          ProfileWidget(
            title: 'Kebijakan Privasi',
          ),
          ProfileWidget(
            title: 'Ketentuan Pengguna',
          ),
          ProfileWidget(
            title: 'Laporkan Masalah',
          ),
          ProfileWidget(
            title: 'Versi Aplikasi',
          ),
          ProfileWidget(
            title: 'Tentang Kami',
          ),
          ProfileWidget(
            title: 'Log Out',
          ),
        ],
      ),
    );
  }
}
