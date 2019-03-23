import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:giphy_searcher/repository/GifRepository.dart';
import 'package:giphy_searcher/utils/ColorUtils.dart';

class GifImage extends StatefulWidget {
  String url;
  double width;
  double height;
  BoxFit fit;

  GifImage(String url, double width, double height) {
      this.url = url;
      this.width = width;
      this.height = height;
  }

  @override
  State createState() => GifState();
}

class GifState extends State<GifImage> {
  Future<Uint8List> imageBytes;

  @override
  void initState() {
    imageBytes = GifRepository.loadImage(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
          future: imageBytes,
          builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              if(snapshot.hasData) {
                  final image = Image.memory(
                      snapshot.data,
                      width: widget.width,
                      height: widget.height,
                      fit: widget.fit);
                  return image;
              } else {
                  return Center(
                      child: Container(
                          width: widget.width,
                          height: widget.height,
                          child: Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorUtils.getRandomColor()
                                  )
                              )
                          )
                      )
                  );
              }
          }
      );
  }
}