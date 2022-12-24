import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Text(
          "Kursus",
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(4.0),
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
                width: MediaQuery.of(context).size.width,
                height: 558,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: courseData.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  courseData[index]['name'] ?? "No Name",
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      courseData[index]['rating'].toString(),
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
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
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
