import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_to_pdf/screens/readerScreen.dart';
import 'package:path/path.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class PreviewImageScreen extends StatefulWidget {
  final String pdfPath;
  final String imageRoute;

  PreviewImageScreen(this.pdfPath, this.imageRoute);

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    // User pdfViewer to preview the generated pdf by giving the pdf link
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: PdfViewer(
              filePath: widget.pdfPath,
            ),
          ),
          Positioned(
            bottom: 1,
            left: 50,
            child: IconButton(
                icon: Icon(Icons.chrome_reader_mode),
                iconSize: 25,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReaderScreen(imageRoute: widget.imageRoute),
                      ));
                }),
          ),
          Positioned(
            bottom: 1,
            left: 100,
            right: 100,
            child: IconButton(
                icon: Icon(Icons.save_alt),
                iconSize: 25,
                color: Colors.blue,
                onPressed: () {}),
          ),
          Positioned(
            bottom: 1,
            right: 50,
            child: IconButton(
                icon: Icon(Icons.share),
                iconSize: 25,
                color: Colors.blue,
                onPressed: () {
                  getBytesFromFile().then((bytes) {
                      Share.file('Share via:', basename(widget.pdfPath),
                          bytes.buffer.asUint8List(), 'image/png');
                    });
                }),
          ),
        ],
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.pdfPath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
