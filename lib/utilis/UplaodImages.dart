import 'package:path/path.dart' as Path;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String?> uploadImage(String dbpath, File file) async {
  final _storage = FirebaseStorage.instance;

  //permission
  if (file != null) {
    var snapshot = await _storage.ref().child(dbpath).putFile(file);
    String downloadurl = (await snapshot.ref.getDownloadURL()).toString();

    print("Url: $downloadurl");
    return downloadurl;
  } else {
    print('No Path Received');
    return null;
  }
}

Future<void> deleteImage(String imageFileUrl) async {
  final _storage = FirebaseStorage.instance;
  var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
      .replaceAll(new RegExp(r'(\?alt).*'), '');

  await _storage.ref().child(fileUrl).delete();
}

Future<File?> getfilepath() async {
  final _picker = ImagePicker();
  final XFile? image;
  //permission
  await Permission.photos;
  var permissionStatus = await Permission.photos.status;
  image = (await _picker.pickImage(source: ImageSource.gallery))  ;
  var file = File(image!.path);
  print("File: ${file}");
  print("Image: ${image.path}");
  return file;

  // if (permissionStatus.isGranted) {
  //
  // } else {
  //   print('No Path Received');
  //   return null;
  // }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);
  var dir = Directory.current.path;

  final file = await _localFile;
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/temp.png');
}
