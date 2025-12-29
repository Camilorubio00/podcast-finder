import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import '../../widgets/error_message_widget.dart';
import 'detail_notifier_provider.dart';
import 'detail_state.dart';

class PodcastDetailScreen extends ConsumerStatefulWidget {
  const PodcastDetailScreen({
    super.key,
    required this.podcastId,
  });

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
      DetailLoading() => _buildLoadingState(),
      DetailSuccess(podcastDetail: var podcastDetail) => Text('Success: ${podcastDetail.title}'),
      DetailError(message: var message) => _buildErrorState(message),
    };
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String message) {
    return ErrorMessageWidget(
      message: message,
      onRetry: () {
        ref.read(detailNotifierProvider.notifier).getPodcastById(widget.podcastId);
      },
    );
  }
}

