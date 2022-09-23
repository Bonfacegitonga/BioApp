
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


import '../model/firebaseFile.dart';
import '../resoure/color.dart';
import '../widget/progress_indicator.dart';

class ViewPdf extends StatefulWidget {
  final FirebaseFile pdffile;
  final String title;
  const ViewPdf({Key? key, required this.pdffile, required this.title})
      : super(key: key);

  @override
  _ViewPdf createState() => _ViewPdf();
}

class _ViewPdf extends State<ViewPdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late final path = widget.pdffile.url;
  Uint8List ? _documentBytes;
  PdfViewerController? _pdfViewerController;
 

  @override
  void initState() {
    getPdfData();
    super.initState();
    
  }

   getPdfData() async{
 
    HttpClient client = HttpClient();
    final Uri url = Uri.base.resolve(path);
    final HttpClientRequest request = await client.getUrl(url);
    final HttpClientResponse response = await request.close();
     _documentBytes = await consolidateHttpClientResponseBytes(response);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
  Widget child = const Center(child: MyProgressIndicator());
   if (_documentBytes != null) {
    child = SfPdfViewer.memory(
      _documentBytes!,
      controller: _pdfViewerController,
      key: _pdfViewerKey,
    );
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: mainColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.list,
              color: Colors.white,
              semanticLabel: 'Content',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),

        ],
      ),
      body: child
    );
  }
}
