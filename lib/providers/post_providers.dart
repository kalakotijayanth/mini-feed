import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/post_model.dart';
import '../data/services/firestore_service.dart';
import '../data/repositories/post_repository.dart';
import '../data/services/storage_service.dart';
import 'feed_notifier.dart';

final firestoreServiceProvider = Provider<FireStoreService>((ref) => FireStoreService(),);
final storageServiceProvider = Provider((ref) => StorageService());

final postRepositoryProvider = Provider((ref) => PostRepository(ref.read(firestoreServiceProvider), ref.read(storageServiceProvider),),);
final feedNotifierProvider = AsyncNotifierProvider<FeedNotifier, List<Post>>(FeedNotifier.new,);
