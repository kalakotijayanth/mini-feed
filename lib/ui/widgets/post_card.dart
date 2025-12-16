import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_feed/core/utils/helper.dart';
import '../../data/models/post_model.dart';
import '../../providers/post_providers.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
            child: Image.network(
              post.imageUrl,
              width: double.infinity,
              height: getHeight(context)/4,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            post.userName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(post.caption),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ref.read(feedNotifierProvider.notifier).toggleLike(
                    postId: post.id,
                    isLike: true,
                  );
                },
              ),
              Text('${post.likesCount} likes'),
            ],
          ),
        ],
      ),
    );
  }
}
