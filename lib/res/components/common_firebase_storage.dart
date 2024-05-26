import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CommonFirebaseStorage {
  Future<String> storeFileFileToFirebase(String ref, File file) async {
    var storage = FirebaseStorage.instance;
    UploadTask uploadTask = storage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}
