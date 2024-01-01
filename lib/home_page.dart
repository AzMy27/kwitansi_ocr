import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:ocr/Utils/image_cropper_page.dart';
import 'package:ocr/Utils/image_picker_class.dart';
import 'package:ocr/Widgets/modal_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Tambahkan widget yang lain di sini jika diperlukan
            FloatingActionButton.extended(
              tooltip: 'Increment',
              label: const Text("Scan photo"),
              onPressed: () {
                imagePickerModal(context, onCameraTap: () {
                  log("Camera");
                  pickImage(source: ImageSource.camera).then((value) {
                    if (value != '') {
                      imageCropperView(value, context).then((value) {
                        if (value != '') {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RecognizePage(
                                path: value,
                              ),
                            ),
                          );
                        }
                      });
                    }
                  });
                }, onGalleryTap: () {
                  log("Gallery");
                  pickImage(source: ImageSource.gallery).then((value) {
                    if (value != '') {
                      imageCropperView(value, context).then((value) {
                        if (value != '') {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RecognizePage(
                                path: value,
                              ),
                            ),
                          );
                        }
                      });
                    }
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
