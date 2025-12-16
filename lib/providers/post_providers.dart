import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/post_model.dart';
import '../data/services/firestore_service.dart';
import '../data/repositories/post_repository.dart';
import 'feed_notifier.dart';

final firestoreServiceProvider = Provider<FireStoreService>((ref) => FireStoreService(),);

final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepository(ref.read(firestoreServiceProvider)),);

final feedNotifierProvider = AsyncNotifierProvider<FeedNotifier, List<Post>>(FeedNotifier.new,);
