import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/podcast_model.dart';
import '../../widgets/podcast_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final hardcodedPodcasts = [
    const PodcastModel(
      id: 'hardcoded-1',
      title: 'The Daily Tech',
      publisher: 'Tech News Network',
      imageUrl: 'https://picsum.photos/seed/daily/200',
      description: 'Your source for daily technology news and updates.',
    ),
    const PodcastModel(
      id: 'hardcoded-2',
      title: 'Science Weekly',
      publisher: 'Science Publishers',
      imageUrl: 'https://picsum.photos/seed/science/200',
      description: 'Explore the latest discoveries in science and research.',
    ),
    const PodcastModel(
      id: 'hardcoded-3',
      title: 'Business Insights',
      publisher: 'Business Media Co',
      imageUrl: 'https://picsum.photos/seed/business/200',
      description: 'Deep dives into successful business strategies.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PodcastFinder'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Container(
            height: 48,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
              onChanged: (value) =>
                  ref.read(searchNotifierProvider.notifier).search(value),
              decoration: InputDecoration(
                hintText: 'Search podcasts...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
          Expanded(child: _buildBody(ref, state)),
        ],
      ),
    );
  }

  Widget _buildBody(WidgetRef ref, SearchState state) {
    return switch (state) {
      SearchInitial() => _buildPodcastList(hardcodedPodcasts),
      SearchLoading() => const Center(child: CircularProgressIndicator()),
      SearchEmpty() => const Center(child: Text('No podcasts found')),
      SearchError(message: var msg) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(msg), const Text('Try writing another word')],
        ),
      ),
      SearchSuccess(podcastModelList: var list) => _buildPodcastList(list),
    };
  }

  Widget _buildPodcastList(List<PodcastModel> podcasts) {
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return PodcastCard(
          podcast: podcast,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Detail screen not implemented yet'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }
}
