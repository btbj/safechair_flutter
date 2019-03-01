// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

class ReaderPage extends StatefulWidget {
  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  List<CameraDescription> cameras;
  QRReaderController controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void initCamera() async {
    cameras = await availableCameras();
    controller = QRReaderController(
      cameras[0],
      ResolutionPreset.medium,
      [CodeFormat.qr],
      onGetResult,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  void onGetResult(dynamic value) {
    print(value);
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text('scan');
    if (controller != null && controller.value.isInitialized) {
      content = Container(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: QRReaderPreview(controller),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: content,
      ),
    );
  }
}
