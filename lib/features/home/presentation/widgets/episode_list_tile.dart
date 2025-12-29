import 'package:flutter/material.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import 'package:podcast_finder/core/utils/date_formatter.dart';
import 'package:podcast_finder/core/utils/duration_formatter.dart';
import '../../data/models/episode_model.dart';

class EpisodeListTile extends StatelessWidget {
  const EpisodeListTile({super.key, required this.episode});

  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 8),
            _buildTimeDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      episode.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTimeDescription() {
    final duration = DurationFormatter.formatDuration(episode.audioLengthSec);
    final publishDate = DateFormatter.formatDate(episode.publishDateMs);
    return Text(
      '$publishDate • $duration',
      style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
    );
  }
}
