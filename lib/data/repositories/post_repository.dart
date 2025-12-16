import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../services/firestore_service.dart';

class PostRepository {
  final FireStoreService _firestoreService;

  PostRepository(this._firestoreService);

  Stream<List<Post>> getPosts() {
    return _firestoreService.getPostsStream().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromFirestore(doc))
            .toList();
      },
    );
  }

  Future<void> addPost(Post post) async {
    try {
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
