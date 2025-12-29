import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/presentation/screens/home/home_screen.dart';
import '../../features/home/presentation/screens/detail/podcast_detail_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/podcast/:id',
        name: 'detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PodcastDetailScreen(podcastId: id);
        },
      ),
    ],
  );
});