import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import 'package:podcast_finder/features/home/presentation/widgets/detail_screen_shimmer.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import 'package:podcast_finder/features/home/presentation/widgets/podcast_detail_image.dart';
import '../../widgets/error_message_widget.dart';
import '../../widgets/episode_list_tile.dart';
import 'detail_notifier_provider.dart';
import 'detail_state.dart';

class PodcastDetailScreen extends ConsumerStatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcastId});

  final String podcastId;

  @override
  ConsumerState<PodcastDetailScreen> createState() =>
      _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends ConsumerState<PodcastDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(detailNotifierProvider.notifier).getPodcastById(widget.podcastId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
        title: state is DetailSuccess
            ? Text(
                state.podcastDetail.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(DetailState state) {
    return switch (state) {
      DetailInitial() => const SizedBox.shrink(),
      DetailLoading() => const DetailScreenShimmer(),
      DetailSuccess(podcastDetail: var podcastDetail) => _buildSuccessState(
        podcastDetail,
      ),
      DetailError(message: var message) => _buildErrorState(message),
    };
  }

  Widget _buildSuccessState(PodcastDetailModel podcastDetail) {
    final episodes = podcastDetail.episodes.take(5).toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PodcastDetailImage(imageUrl: podcastDetail.image),
          _buildPodcastTitle(podcastDetail.title),
          _buildPodcastPublisher(podcastDetail.publisher),
          _buildPodcastDescription(podcastDetail.description),
          if (podcastDetail.genreIds != null &&
              podcastDetail.genreIds!.isNotEmpty)
            _buildGenreTagsSection(podcastDetail.genreIds!),
          _buildRecentEpisodesTitle(),
          ...episodes.map((episode) => EpisodeListTile(episode: episode)),
        ],
      ),
    );
  }

  Widget _buildPodcastTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildPodcastPublisher(String publisher) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        publisher,
        style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildPodcastDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildGenreTagsSection(List<int> genreIds) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genreIds.map<Widget>((genreId) {
          return Chip(
            label: Text(
              'Genre $genreId',
              style: const TextStyle(color: AppColors.primary, fontSize: 14),
            ),
            backgroundColor: AppColors.surfaceVariant,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentEpisodesTitle() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Text(
        'Recent Episodes',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: ErrorMessageWidget(
        message: message,
        onRetry: () {
          ref.read(detailNotifierProvider.notifier).getPodcastById(widget.podcastId);
        },
      ),
    );
  }
}
