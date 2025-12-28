import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_notifier.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_notifier_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_state.dart';
import '../fixtures/podcast_fixtures.dart';

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  late DetailNotifier notifier;
  late MockPodcastRepository mockRepository;

  setUp(() {
    mockRepository = MockPodcastRepository();
    notifier = DetailNotifier(mockRepository);
  });

  tearDown(() {
    notifier.dispose();
  });

  group('detailNotifier', () {
    test('Initial state should be DetailInitial', () {
      expect(notifier.state, isA<DetailInitial>());
    });

    test('Should emit [Loading, Success] in order', () async {
      final states = <DetailState>[];
      notifier.addListener((state) => states.add(state));

      when(() => mockRepository.getPodcastBy(id: any(named: 'id')))
          .thenAnswer((_) async => PodcastFixtures.mockPodcastDetail);

      await notifier.getPodcastById(PodcastFixtures.mockPodcastId);

      expect(states, [
        isA<DetailInitial>(),
        isA<DetailLoading>(),
        isA<DetailSuccess>(),
      ]);

      final lastState = states.last as DetailSuccess;
      expect(lastState.podcastDetail.id, PodcastFixtures.mockPodcastId);
      expect(lastState.podcastDetail.episodes.length, 3);
    });

    test('Should emit [Loading, Error] when NetworkException occurs', () async {
      final states = <DetailState>[];
      notifier.addListener((state) => states.add(state));

      const networkException = TimeoutException();

      when(() => mockRepository.getPodcastBy(id: any(named: 'id')))
          .thenThrow(networkException);

      await notifier.getPodcastById(PodcastFixtures.mockPodcastId);

      expect(states, [
        isA<DetailInitial>(),
        isA<DetailLoading>(),
        isA<DetailError>(),
      ]);

      final lastState = states.last as DetailError;
      expect(lastState.message, networkException.message);
    });

    test('Should emit [Loading, Error] when generic exception occurs', () async {
      final states = <DetailState>[];
      notifier.addListener((state) => states.add(state));

      when(() => mockRepository.getPodcastBy(id: any(named: 'id')))
          .thenThrow(Exception('Generic error'));

      await notifier.getPodcastById(PodcastFixtures.mockPodcastId);

      expect(states, [
        isA<DetailInitial>(),
        isA<DetailLoading>(),
        isA<DetailError>(),
      ]);

      final lastState = states.last as DetailError;
      expect(lastState.message, contains('Generic error'));
    });
  });

  group('detailNotifierProvider', () {
    test('Should provide a DetailNotifier instance with DetailInitial state', () {
      final container = ProviderContainer(
        overrides: [
          podcastRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(detailNotifierProvider.notifier),
          isA<DetailNotifier>());
      expect(container.read(detailNotifierProvider), isA<DetailInitial>());
    });
  });
}

