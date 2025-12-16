import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String caption;
  final String userName;
  final int likesCount;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.imageUrl,
    required this.caption,
    required this.userName,
    required this.likesCount,
    required this.createdAt,
  });

  factory Post.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data();

    return Post(
      id: doc.id,
      imageUrl: data?['imageUrl'].toString() ?? '',
      caption: data?['caption'].toString() ?? '',
      userName: data?['userName'].toString() ?? 'Anonymous',
      likesCount: data?['likesCount'] as int? ?? 0,
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'caption': caption,
      'userName': userName,
      'likesCount': likesCount,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
