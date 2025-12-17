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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLikes({
    required String postId,
    required String userId,
  }) async {
    final postDocRef = _postsRef.doc(postId);

    await fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(postDocRef);

      if (!snapshot.exists) {
        throw Exception('Post does not exist');
      }

      final data = snapshot.data()!;
      final int currentLikes = data['likesCount'] ?? 0;
      final List likedBy = data['likedBy'] ?? [];

      if (likedBy.contains(userId)) {
        transaction.update(postDocRef, {
          'likesCount': currentLikes - 1,
          'likedBy': FieldValue.arrayRemove([userId]),
        });
      } else {
        transaction.update(postDocRef, {
          'likesCount': currentLikes + 1,
          'likedBy': FieldValue.arrayUnion([userId]),
        });
      }
    });
  }

}
