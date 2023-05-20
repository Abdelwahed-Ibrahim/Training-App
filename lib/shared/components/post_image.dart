import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.imageLink,
  });

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image(
        image: NetworkImage(imageLink),
        fit: BoxFit.fill,
      ),
    );
  }
}
