import 'package:dio/dio.dart';

/// Interceptor that simulates API responses for testing
/// In a real scenario, you would remove this and use actual API calls
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if this is a search request
    if (options.path.contains('/search')) {
      final query = options.queryParameters['q'] ?? '';
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockSearchResponse(query),
        ),
      );
      return;
    }
    
    // Check if this is a podcast detail request
    if (options.path.contains('/podcasts/')) {
      final id = options.path.split('/').last;
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockPodcastDetailResponse(id),
        ),
      );
      return;
    }
    
    // Pass through if no mock is found
    handler.next(options);
  }

Map<String, dynamic> _getMockSearchResponse(String query) {
  final allResults = [
    {
      'id': 'podcast-1',
      'title': 'Tech Talk Daily',
      'publisher': 'Tech Media Inc',
      'thumbnail': 'https://picsum.photos/seed/podcast1/200',
      'description_original': 'Your daily dose of technology news and insights. We cover everything from startups to AI.',
    },
    {
      'id': 'podcast-2',
      'title': 'The Science Show',
      'publisher': 'Science Network',
      'thumbnail': 'https://picsum.photos/seed/podcast2/200',
      'description_original': 'Exploring the wonders of science, from quantum physics to biology.',
    },
    {
      'id': 'podcast-3',
      'title': 'Business Builders',
      'publisher': 'Entrepreneur Media',
      'thumbnail': 'https://picsum.photos/seed/podcast3/200',
      'description_original': 'Stories and strategies from successful entrepreneurs around the world.',
    },
  ];

  final filteredResults = allResults.where((podcast) {
    final title = podcast['title'].toString().toLowerCase();
    final publisher = podcast['publisher'].toString().toLowerCase();
    final searchTerm = query.toLowerCase();

    return title.contains(searchTerm) || publisher.contains(searchTerm);
  }).toList();

  return {
    'count': filteredResults.length,
    'results': filteredResults,
  };
}

  Map<String, dynamic> _getMockPodcastDetailResponse(String id) {
    return {
      'id': id,
      'title': 'Tech Talk Daily',
      'publisher': 'Tech Media Inc',
      'image': 'https://picsum.photos/seed/$id/400',
      'description': 'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
      'genre_ids': [127, 93],
      'episodes': [
        {
          'id': 'episode-1',
          'title': 'The Future of AI Development',
          'description': 'We discuss the latest trends in AI with leading researchers.',
          'pub_date_ms': 1702857600000, // Dec 18, 2023
          'audio_length_sec': 3600,
        },
        {
          'id': 'episode-2',
          'title': 'Cloud Computing in 2024',
          'description': 'What to expect from cloud providers this year.',
          'pub_date_ms': 1702771200000, // Dec 17, 2023
          'audio_length_sec': 2700,
        },
        {
          'id': 'episode-3',
          'title': 'Startup Funding Strategies',
          'description': 'How to approach investors and secure funding.',
          'pub_date_ms': 1702684800000, // Dec 16, 2023
          'audio_length_sec': 3300,
        },
      ],
    };
  }
}