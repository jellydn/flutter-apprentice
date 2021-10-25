import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({Key? key, this.imageRadius = 20, this.imageProvider})
      : super(key: key);

  final double imageRadius;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: imageRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
