import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/course_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List courseData = [];
  bool _isLoading = true;
  Future getCourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await getAllData(prefs.getString("key")!);
    if (apiResponse.statusCode == 200) {
      final data = jsonDecode(apiResponse.body);

      setState(() {
        courseData = data['courses'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow,
        title: Text(
          "Hai, User",
          style: GoogleFonts.workSans(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 390,
                  height: 74,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: SizedBox(
                          width: 298,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.black),
                                    borderRadius: BorderRadius.circular(16)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.black),
                                    borderRadius: BorderRadius.circular(16)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.black),
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: 'Mau Belajar Apa Hari Ini ?'),
                          ),
                        ),
                      ),
                      const Icon(Icons.notifications)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 351,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ikuti Kursus",
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseScreen()));
                      },
                      child: Text(
                        "Lihat Semua",
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: courseData.length < 7 ? courseData.length : 7,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 0,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        children: [
                          Container(
                            width: 200,
                            height: 230,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 125,
                                  child: Image.network(
                                      "https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  courseData[index]['name'] ?? "No Name",
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_outlined,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          courseData[index]['rating']
                                              .toString(),
                                          style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "${courseData[index]['capacity']} x Pertemuan",
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 351,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kursusku",
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      "Lihat Semua",
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            'https://img.freepik.com/premium-vector/young-caucasian-man-with-laptop-sitting-big-book-stack-online-education-concept-remote-studying-concept-flat-style-vector-illustration_285336-2679.jpg?w=2000',
                          ),
                          Text(
                            'Belajar Materi??',
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Image.network(
                              'https://img.freepik.com/free-vector/internship-concept-illustration_114360-6225.jpg?w=2000'),
                          Text(
                            'Latihan Soal',
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
