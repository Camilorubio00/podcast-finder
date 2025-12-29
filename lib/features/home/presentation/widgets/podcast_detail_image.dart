import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';

class PodcastDetailImage extends StatelessWidget {
  final String imageUrl;
  const PodcastDetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorContainer(),
        ),
        _buildGradientOverlay(),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 300,
      color: AppColors.surfaceVariant,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorContainer() {
    return Container(
      width: double.infinity,
      height: 300,
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.podcasts,
        size: 60,
        color: AppColors.textTertiary,
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white.withValues(alpha: 0.8)],
          ),
        ),
      ),
    );
  }
}
