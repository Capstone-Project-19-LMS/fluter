import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok19lmsproject/api/api.dart';
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
      // body:
      // ListView.separated(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: courseData.length,
      //   itemBuilder: (context, index) => Container(
      //     width: 150,
      //     height: 50,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(10),
      //       boxShadow: const [
      //         BoxShadow(
      //           color: Colors.black,
      //           blurRadius: 3,
      //           offset: Offset(0, 0), // changes position of shadow
      //         ),
      //       ],
      //     ),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //             width: double.infinity,
      //             height: 115,
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 35, vertical: 20),
      //               child: Image.network(
      //                   "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
      //             )),
      //         Padding(
      //           padding: const EdgeInsets.only(bottom: 5, left: 8, right: 8),
      //           child: Text(
      //             courseData[index]['name'] ?? "No Name",
      //           ),
      //         ),
      //         Text(courseData[index]['description'] ?? "No Description"),
      //       ],
      //     ),
      //   ),
      //   separatorBuilder: (context, index) => const SizedBox(
      //     width: 16,
      //   ),
      // ),
      // {
      // return Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: InkWell(
      //     onTap: () {},
      //     child: ListTile(
      //       leading:
      // CachedNetworkImage(
      //   imageUrl:
      //       "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
      //   progressIndicatorBuilder: (context, url, downloadProgress) =>
      //       CircularProgressIndicator(
      //           value: downloadProgress.progress),
      //   errorWidget: (context, url, error) => Icon(Icons.error),
      // ),
      //           Image.network(
      //         // courseData[index]['thumbnail'] ??
      //         "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
      //         fit: BoxFit.cover,
      //         // width: 100,
      //       ),
      //       title: Text(
      //         courseData[index]['name'] ?? "No Name",
      //         maxLines: 1,
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //       subtitle: Text(
      //         courseData[index]['description'] ?? "No Description",
      //         maxLines: 2,
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     ),
      //   ),
      // );
      // },

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
                      // color: Colors.green,
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
                            // margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 125,
                                  child: Image.network(
                                      "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
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
                  // Container(
                  //   width: 100,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Colors.black,
                  //         blurRadius: 3,
                  //         offset: Offset(0, 0), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  // SizedBox(
                  //     width: double.infinity,
                  //     height: 115,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 35, vertical: 20),
                  //       child: Image.network(
                  //           "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                  //     )),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       bottom: 5, left: 8, right: 8),
                  //   child: Text(
                  //     courseData[index]['name'] ?? "No Name",
                  //   ),
                  // ),
                  // Text(courseData[index]['description'] ??
                  //     "No Description"),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
              // ListView.builder(
              //   itemCount: courseData.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: EdgeInsets.all(10),
              //       child: ListTile(
              //         title: Text(courseData[index]['name'] ?? "No Name"),
              //       ),
              //     );
              //   },
              // ),
              // CarouselSlider(
              //   items: [
              //     Container(
              //       margin: const EdgeInsets.all(6.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         image: const DecorationImage(
              //           image: NetworkImage(
              //               "https://images.unsplash.com/photo-1617040619263-41c5a9ca7521?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.all(6.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         image: const DecorationImage(
              //           image: NetworkImage(
              //               "https://images.unsplash.com/photo-1633356122544-f134324a6cee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.all(6.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         image: const DecorationImage(
              //           image: NetworkImage(
              //               "https://images.unsplash.com/photo-1602576666092-bf6447a729fc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1332&q=80"),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.all(6.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         image: const DecorationImage(
              //           image: NetworkImage(
              //               "https://images.unsplash.com/photo-1515879218367-8466d910aaa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHl0aG9uJTIwcHJvZ3JhbW1pbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.all(6.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         image: const DecorationImage(
              //           image: NetworkImage(
              //               "https://images.unsplash.com/photo-1627398242454-45a1465c2479?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //   ],
              //   options: CarouselOptions(
              //     height: 150.0,
              //     enlargeCenterPage: true,
              //     autoPlay: true,
              //     aspectRatio: 16 / 9,
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enableInfiniteScroll: true,
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     viewportFraction: 0.8,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 351,
                height: 40,
                child: Text(
                  "Kegiatan?",
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black),
                  ),
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
