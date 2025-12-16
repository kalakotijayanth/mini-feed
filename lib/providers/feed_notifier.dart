import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_feed/providers/post_providers.dart';

import '../data/models/post_model.dart';
import '../data/repositories/post_repository.dart';

class FeedNotifier extends AsyncNotifier<List<Post>> {
  late final PostRepository _repository;
  StreamSubscription<List<Post>>? _subscription;

  @override
  Future<List<Post>> build() async {
    _repository = ref.read(postRepositoryProvider);

    // Initial loading state
    state = const AsyncLoading();

    _subscription = _repository.getPosts().listen(
          (posts) {
        state = AsyncData(posts);
      },
      onError: (error, stackTrace) {
        state = AsyncError(error, stackTrace);
      },
    );

    return [];
  }

  Future<void> createPost({
    required File imageFile,
    required String caption,
  }) async {
    try {
      await _repository.createPost(
        imageFile: imageFile,
        caption: caption,
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleLike({
    required String postId,
    required bool isLike,
  }) async {
    try {
      await _repository.updateLikes(
        postId: postId,
        isLike: isLike,
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }


}
