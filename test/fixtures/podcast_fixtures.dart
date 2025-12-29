import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

class PodcastFixtures {
  static const String mockSearchPath = '/search';
  static const String mockQueryKey = 'q';
  static const String mockQueryValue = 'tech';
  static const String mockPodcastId = 'podcast-1';
  static const String mockDetailPath = '/podcasts/podcast-1';

  static const Map<String, dynamic> mockPodcastResponse = {
    'results': [
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
        'description_original':'Exploring the wonders of science, from quantum physics to biology.',
      },
    ],
  };

  static final List<PodcastModel> mockPodcastModelList = (mockPodcastResponse['results'] as List)
          .map((json) => PodcastModel.fromJson(json))
          .toList();

  static PodcastModel get mockFirstPodcast => mockPodcastModelList.first;

  static final PodcastModel mockPodcastNoDesc = const PodcastModel(
    id: '1',
    title: 'No Desc',
    publisher: 'Pub',
    imageUrl: '',
    description: null,
  );

  static const Map<String, dynamic> mockPodcastDetailResponse = {
      'id': 'podcast-1',
      'title': 'Tech Talk Daily',
      'publisher': 'Tech Media Inc',
      'image': 'https://picsum.photos/seed/podcast-1/400',
      'description': 'Your daily dose of technology news and insights. We cover everything from startups to AI, blockchain to cloud computing. Join us every day for in-depth discussions with industry leaders.',
      'genre_ids': [127, 93],
      'episodes': [
        {
          'id': 'episode-1',
          'title': 'The Future of AI Development',
          'description': 'We discuss the latest trends in AI with leading researchers.',
          'pub_date_ms': 1702857600000, 
          'audio_length_sec': 3600,
        },
        {
          'id': 'episode-2',
          'title': 'Cloud Computing in 2024',
          'description': 'What to expect from cloud providers this year.',
          'pub_date_ms': 1702771200000, 
          'audio_length_sec': 2700,
        },
        {
          'id': 'episode-3',
          'title': 'Startup Funding Strategies',
          'description': 'How to approach investors and secure funding.',
          'pub_date_ms': 1702684800000, 
          'audio_length_sec': 3300,
        },
      ],
    };
  
  static final PodcastDetailModel mockPodcastDetail =
      PodcastDetailModel.fromJson(mockPodcastDetailResponse);

  static final List<EpisodeModel> mockEpisodesList =
      (mockPodcastDetailResponse['episodes'] as List)
          .map((json) => EpisodeModel.fromJson(json))
          .toList();
}
