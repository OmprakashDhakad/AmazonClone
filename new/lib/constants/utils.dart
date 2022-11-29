import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
// Future<List<Uint8List>> pickImages() async {
  // List<Uint8List> images = [];
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    //Uint8List uploadfile = result.files.single.bytes;
    // ignore: unrelated_type_equality_checks
    if (files != Null && files!.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        // images.add(files.files[i].bytes!);
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
