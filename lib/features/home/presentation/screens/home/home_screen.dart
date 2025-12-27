import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/podcast_model.dart';
import '../../widgets/podcast_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded podcasts for the base project
    // Candidates will replace this with actual API calls
    final hardcodedPodcasts = [
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('PodcastFinder'),
      ),
      body: Column(
        children: [
          // Search hint (not functional yet - candidates will implement)
          Container(
            padding: const EdgeInsets.all(16),
            child: const TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Search podcasts...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Tooltip(
                  message: 'This feature needs to be implemented',
                  child: Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          // Hardcoded list
          Expanded(
            child: ListView.builder(
              itemCount: hardcodedPodcasts.length,
              itemBuilder: (context, index) {
                final podcast = hardcodedPodcasts[index];
                return PodcastCard(
                  podcast: podcast,
                  onTap: () {
                    // TODO: Navigate to detail screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Detail screen not implemented yet'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}