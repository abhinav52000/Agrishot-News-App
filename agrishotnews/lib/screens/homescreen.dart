import 'dart:convert';
import 'package:agrishotnews/screens/bookmarkslist.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:agrishotnews/utitlities/getnewsapi.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This is the very first screen showing all the latest news.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const id = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic response;
  @override
  void initState() {
    getnewshere();
    initPlatformState();

    super.initState();
  }

  // This is the function to find the device token.
  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      deviceId = udid;
    });
  }

  List<int> index = [];
  List<bool> bookmark = [];
  String deviceId = '';

  // This function is to get the news response.
  getnewshere() async {
    response = await getnews();
    setState(() {});
    while (response == null) {
      getnewshere();
      deviceId = await FlutterUdid.udid;
    }
    response = jsonDecode(response.body);
    for (int i = 0; i < response['data'].length; ++i) {
      index.add(i);
      bookmark.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              'Agri',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'shots',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                BookMarkScreen.id,
                arguments: deviceId,
              );
            },
            icon: const Icon(
              Icons.bookmark_added,
            ),
          )
        ],
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          padEnds: false,
          height: MediaQuery.of(context).size.height + 50,
          scrollDirection: Axis.vertical,
          enableInfiniteScroll: false,
        ),
        items: index.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Image.network(
                    response['data'][i]['mediaslug'],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('asset/1.png');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          response['data'][i]['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Agrishots',
                                  hintStyle: TextStyle(color: Colors.white),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  enabled: false,
                                ),
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              // response['data'][i]['createdAt']
                              DateFormat.yMMMEd().format(
                                DateTime.now(),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() async {
                                  try {
                                    bookmark[i] = !bookmark[i];
                                    print('Mera device id $deviceId');
                                    var postlink = Uri.parse(
                                      'https://api.dev.agrishots.in/articles/${response['data'][i]['id']}/toggle-bookmark',
                                    );
                                    var result = await http.post(
                                      postlink,
                                      headers: {
                                        'x-device-hash': deviceId,
                                      },
                                    );
                                    print(jsonDecode(result.toString()));
                                  } catch (e) {
                                    setState(() {
                                      bookmark[i] = !bookmark[i];
                                    });
                                    print(e);
                                  }
                                });
                              },
                              icon: Icon(
                                bookmark[i]
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          response['data'][i]['description'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
