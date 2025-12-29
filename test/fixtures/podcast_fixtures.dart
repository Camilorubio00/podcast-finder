import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

class PodcastFixtures {
  static const String mockSearchPath = '/search';
  static const String mockQueryKey = 'q';
  static const String mockQueryValue = 'tech';

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
}
