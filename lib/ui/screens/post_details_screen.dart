import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_feed/core/utils/helper.dart';

import '../../data/models/post_model.dart';
import '../../providers/post_providers.dart';

class PostDetailsScreen extends ConsumerStatefulWidget {
  final String postId;
  const PostDetailsScreen({super.key,required this.postId});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends ConsumerState<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    const userId = 'demo_user';
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final post = Post.fromFirestore(snapshot.data!);
          final isLiked = post.likedBy.contains(userId);

          return ListView(
            padding: EdgeInsets.all(10),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  post.imageUrl,
                  width: double.infinity,
                  height: getHeight(context)/4,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('Posted By : ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Caption : ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),

                      Flexible(child: Text(post.caption)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(feedNotifierProvider.notifier).toggleLike(
                            postId: post.id,
                            userId: userId,
                          );
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('${post.likesCount} likes'),
                    ],
                  ),

                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
