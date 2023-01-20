import 'dart:convert';

import 'package:agrishotnews/utitlities/bookmarkcard.dart';
import 'package:agrishotnews/utitlities/getbookmarkednews.dart';
import 'package:flutter/material.dart';

// This screen is BoookMark screen.

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key, required this.deviceId});

  final String deviceId;
  static const id = "Bookmark Screen";

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  dynamic response;

  @override
  void initState() {
    getbookmarknewshere();
    super.initState();
  }

  getbookmarknewshere() async {
    response = await getbookmarkednews(widget.deviceId);
    setState(() {});
    while (response == null) {
      getbookmarkednews(widget.deviceId);
    }
    response = jsonDecode(response.body);
    print(response);
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
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: (response['data'] != null)
          ? ListView.builder(
              itemCount: response['data'].length,
              itemBuilder: (context, index) {
                return BookMarkCard(
                  headlineText: response['data'][index]['title'],
                  imageUrl: response['data'][index]['mediaslug'],
                );
              },
            )
          : const Center(
              child: Text(
                'No Bookmarks Added',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
      //In case there is no bookmarks yet we will show this.
    );
  }
}
