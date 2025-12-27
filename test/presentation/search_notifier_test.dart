import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';
import '../fixtures/podcast_fixtures.dart';

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  late MockPodcastRepository mockRepository;
  late SearchNotifier notifier;

  setUp(() {
    mockRepository = MockPodcastRepository();
    notifier = SearchNotifier(mockRepository);
  });

  group('search', () {
    test(
      'Should emit [Loading, Success] when the search is successful',
      () async {
        when(
          () => mockRepository.searchPodcastBy(query: any(named: 'query')),
        ).thenAnswer((_) async => PodcastFixtures.mockPodcastModelList);

        expect(notifier.state, isA<SearchInitial>());

        final future = notifier.search(PodcastFixtures.mockQueryValue);

        expect(notifier.state, isA<SearchLoading>());
        await future;

        expect(notifier.state, isA<SearchSuccess>());
        final successState = notifier.state as SearchSuccess;
        expect(
          successState.podcastModelList,
          PodcastFixtures.mockPodcastModelList,
        );
        verify(
          () => mockRepository.searchPodcastBy(
            query: PodcastFixtures.mockQueryValue,
          ),
        ).called(1);
      },
    );

    test('Should emit [Loading, Empty] when there are no results', () async {
      when(
        () => mockRepository.searchPodcastBy(query: any(named: 'query')),
      ).thenAnswer((_) async => []);

      final future = notifier.search(PodcastFixtures.mockQueryValue);

      expect(notifier.state, isA<SearchLoading>());
      await future;
      expect(notifier.state, isA<SearchEmpty>());
    });

    test('Should emit [Loading, Error] when the repository fails', () async {
      final tError = Exception('Server Error');
      when(
        () => mockRepository.searchPodcastBy(query: any(named: 'query')),
      ).thenAnswer((_) async => throw tError);

      final future = notifier.search(PodcastFixtures.mockQueryValue);

      expect(notifier.state, isA<SearchLoading>());
      await future;
      expect(notifier.state, isA<SearchError>());
      expect((notifier.state as SearchError).message, contains('Server Error'));
    });
  });

  group('searchNotifierProvider', () {
    test(
      'Should provide a SearchNotifier instance with SearchInitial state',
      () {
        final container = ProviderContainer(
          overrides: [
            podcastRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );

        final notifierInstance = container.read(
          searchNotifierProvider.notifier,
        );
        final state = container.read(searchNotifierProvider);

        expect(notifierInstance, isA<SearchNotifier>());
        expect(state, isA<SearchInitial>());
        container.dispose();
      },
    );
  });
}
