import 'package:flutter/material.dart';

// This widget is the card for all bookmarks token.

class BookMarkCard extends StatefulWidget {
  const BookMarkCard({super.key, this.headlineText, this.imageUrl});

  final String? headlineText;
  final String? imageUrl;

  @override
  State<BookMarkCard> createState() => _BookMarkCardState();
}

class _BookMarkCardState extends State<BookMarkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(
        height: 150,
        width: MediaQuery.of(context).size.width,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                widget.headlineText ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )),
          (widget.imageUrl != null)
              ? Image.network(
                  widget.imageUrl ?? "",
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('asset/1.png');
                  },
                  //In case our image url have error then we can handle that exception as well.
                )
              : Image.asset('asset/1.png'),
        ],
      ),
    );
  }
}
