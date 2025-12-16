import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FireStoreService();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _postsRef => fireStore.collection('posts');

  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream() {
    return _postsRef.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addPost(Map<String, dynamic> postData) async {
    try {
      await _postsRef.add(postData);
      print(' Writing to Firestore: $postData');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLikes({
    required String postId,
    required bool isLike,
  }) async {
    final postDocRef = _postsRef.doc(postId);

    await fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(postDocRef);

      if (!snapshot.exists) {
        throw Exception('Post does not exist');
      }

      final currentLikes =
          (snapshot.data()?['likesCount'] as int?) ?? 0;

      final updatedLikes =
      isLike ? currentLikes + 1 : currentLikes - 1;

      transaction.update(postDocRef, {
        'likesCount': updatedLikes < 0 ? 0 : updatedLikes,
      });
    });
  }
}
