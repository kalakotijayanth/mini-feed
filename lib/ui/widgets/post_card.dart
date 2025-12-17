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

  final userId = "demo_user";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = post.likedBy.contains(userId);
    print(post.createdAt);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/postDetail',
          arguments: post.id,
        );
      },
      child: Card(
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
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                children: [
                  Text(
                    'Posted by : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    post.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                children: [
                  Text(
                    'Caption : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Flexible(
                    child: Text(
                      post.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                children: [
                  Text(
                    'Created At : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Flexible(
                    child: Text(
                      '${post.createdAt.day}-${post.createdAt.month}-${post.createdAt.year} '
                          '${post.createdAt.hour}:${post.createdAt.minute}',
                    )

                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
