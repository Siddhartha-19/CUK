import 'dart:html' as html;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Firebase_storage_service {
  Future upload_image_to_storage(
      html.File? image_file, String filename, String folder) async {
    String url = '';
    final storageRef = FirebaseStorage.instance.ref();
    final image_storage_ref = storageRef.child("$folder/$filename");
    final uploadTask = await image_storage_ref.putBlob(image_file);
    final upload_state = uploadTask.state;
    if (upload_state == 'completed') {
      uploadTask.ref.getDownloadURL().then((value) => url = value.toString());
    }
    return url;
  }
}
