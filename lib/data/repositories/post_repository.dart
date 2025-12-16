import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

class PostRepository {
  final FireStoreService _firestoreService;
  final StorageService _storageService;

  PostRepository(this._firestoreService,this._storageService);

  Stream<List<Post>> getPosts() {
    return _firestoreService.getPostsStream().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromFirestore(doc))
            .toList();
      },
    );
  }

  Future<void> createPost({
    required File imageFile,
    required String caption,
  }) async {
    try {
      final imageUrl =
      await _storageService.uploadPostImage(imageFile);

      final post = Post(
        id: '',
        imageUrl: imageUrl,
        caption: caption,
        userName: 'User',
        likesCount: 0,
        createdAt: DateTime.now(),
      );

      await _firestoreService.addPost(post.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLikes({
    required String postId,
    required bool isLike,
  }) async {
    try {
      await _firestoreService.updateLikes(
        postId: postId,
        isLike: isLike,
      );
    } catch (e) {
      rethrow;
    }
  }
}
