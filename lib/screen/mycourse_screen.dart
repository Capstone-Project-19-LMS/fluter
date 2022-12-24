import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok19lmsproject/api/api.dart';
import 'package:kelompok19lmsproject/screen/course_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  List courseHistory = [];

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
    getHistoryCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kursusku",
              style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black,
              )),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 600,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: courseHistory.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.grey.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            Icons.star_outlined,
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
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       children: [
      //         Center(
      //           child: Container(
      //             width: 390,
      //             height: 74,
      //             color: Colors.white,
      //             child: Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: <Widget>[
      //                 Flexible(
      //                   child: SizedBox(
      //                     width: 298,
      //                     child: TextField(
      //                       decoration: InputDecoration(
      //                           prefixIcon: const Icon(Icons.search),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderSide: const BorderSide(
      //                                   width: 3, color: Colors.black),
      //                               borderRadius: BorderRadius.circular(16)),
      //                           focusedBorder: OutlineInputBorder(
      //                               borderSide: const BorderSide(
      //                                   width: 3, color: Colors.black),
      //                               borderRadius: BorderRadius.circular(16)),
      //                           errorBorder: OutlineInputBorder(
      //                               borderSide: const BorderSide(
      //                                   width: 3, color: Colors.black),
      //                               borderRadius: BorderRadius.circular(16)),
      //                           hintText: 'Mau Belajar Apa Hari Ini ?'),
      //                     ),
      //                   ),
      //                 ),
      //                 const Icon(Icons.notifications)
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
