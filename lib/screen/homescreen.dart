import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/course_screen.dart';
import 'package:kelompok19lmsproject/screen/index.dart';
import 'package:kelompok19lmsproject/screen/mycourse_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List courseData = [];
  List courseHistory = [];
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

  Future getHistoryCourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiResponse = await getCourseHistory(prefs.getString("key")!);
    if (apiResponse.statusCode == 200) {
      final data = json.decode(apiResponse.body);
      setState(() {
        courseHistory = data['courses'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCourse();
    getHistoryCourse();
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
                width: MediaQuery.of(context).size.width,
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Index()));
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
                width: MediaQuery.of(context).size.width,
                height: 255,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: courseData.length < 2 ? courseData.length:2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      courseHistory[index]['name'],
                                      style: GoogleFonts.workSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star_outline,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                        Text(
                                          courseHistory[index]['rating']
                                              .toString(),
                                          style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${courseHistory[index]['capacity']} x Pertemuan",
                                      style: GoogleFonts.workSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
}
