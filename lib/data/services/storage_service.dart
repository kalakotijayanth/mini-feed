import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPostImage(File imageFile) async {
    final fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final ref = FirebaseStorage.instance.ref().child(fileName);

    final uploadTask = await ref.putFile(imageFile);

    final downloadUrl = await uploadTask.ref.getDownloadURL();

    return downloadUrl;
  }
}
