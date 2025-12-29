import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import '../fixtures/podcast_fixtures.dart';

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  late SearchNotifier notifier;
  late MockPodcastRepository mockRepository;

  setUp(() {
    mockRepository = MockPodcastRepository();
    notifier = SearchNotifier(mockRepository);
  });

  tearDown(() {
    notifier.dispose();
  });

  Future<void> waitDebouncer() => Future.delayed(const Duration(milliseconds: 550));

  group('searchNotifier', () {
    test('Initial state should be SearchInitial', () {
      expect(notifier.state, isA<SearchInitial>());
    });

    test('Should emit [Loading, Success] in order', () async {
      final states = <SearchState>[];
      notifier.addListener((state) => states.add(state));

      when(() => mockRepository.searchPodcastBy(query: any(named: 'query')))
          .thenAnswer((_) async => PodcastFixtures.mockPodcastModelList);

      notifier.search('podcast');
      await waitDebouncer();

      expect(states, [
        isA<SearchInitial>(),
        isA<SearchLoading>(),
        isA<SearchSuccess>(),
      ]);
    });

    test('Should debounce multiple calls and only call repository once', () async {
      final states = <SearchState>[];
      notifier.addListener((state) => states.add(state));
      
      when(() => mockRepository.searchPodcastBy(query: any(named: 'query')))
          .thenAnswer((_) async => PodcastFixtures.mockPodcastModelList);

      notifier.search('p');
      notifier.search('po');
      notifier.search('pod');

      await waitDebouncer();

      expect(states, [
        isA<SearchInitial>(),
        isA<SearchLoading>(),
        isA<SearchSuccess>(),
      ]);
      
      verify(() => mockRepository.searchPodcastBy(query: 'pod')).called(1);
    });

    test('Should emit [Loading, Error] when NetworkException occurs', () async {
      final states = <SearchState>[];
      notifier.addListener((state) => states.add(state));

      const networkException = TimeoutException();

      when(() => mockRepository.searchPodcastBy(query: any(named: 'query')))
          .thenThrow(networkException);

      notifier.search('error');
      await waitDebouncer();

      expect(states, [
        isA<SearchInitial>(),
        isA<SearchLoading>(),
        isA<SearchError>(),
      ]);
      
      final lastState = states.last as SearchError;
      expect(lastState.message, networkException.message);
    });

    test('Should emit [Loading, Empty] when no results found', () async {
      final states = <SearchState>[];
      notifier.addListener((state) => states.add(state));

      when(() => mockRepository.searchPodcastBy(query: any(named: 'query')))
          .thenAnswer((_) async => []);

      notifier.search('nothing');
      await waitDebouncer();

      expect(states, [
        isA<SearchInitial>(),
        isA<SearchLoading>(),
        isA<SearchEmpty>(),
      ]);
    });

    test('Should emit SearchInitial and NOT call repo if query is empty', () async {
      notifier.search('');
      await waitDebouncer();

      expect(notifier.state, isA<SearchInitial>());
      verifyNever(() => mockRepository.searchPodcastBy(query: any(named: 'query')));
    });
  });

  group('searchNotifierProvider', () {
    test('Should provide a SearchNotifier instance with SearchInitial state', () {
      final container = ProviderContainer(
        overrides: [
          podcastRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(searchNotifierProvider.notifier), isA<SearchNotifier>());
      expect(container.read(searchNotifierProvider), isA<SearchInitial>());
    });
  });
}
