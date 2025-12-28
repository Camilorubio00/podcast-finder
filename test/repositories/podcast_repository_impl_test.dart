import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source_provider.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_impl.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import '../fixtures/podcast_fixtures.dart';

class MockPodcastRemoteDataSource extends Mock implements PodcastRemoteDataSource {}

void main() {
  late MockPodcastRemoteDataSource mockDataSource;
  late PodcastRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockPodcastRemoteDataSource();
    repository = PodcastRepositoryImpl(mockDataSource);
  });

  group('searchPodcasts', () {
    test(
      'Should return the list of podcasts when the data source responds successfully',
      () async {
        when(
          () => mockDataSource.searchPodcastBy(
            query: PodcastFixtures.mockQueryValue,
          ),
        ).thenAnswer((_) async => PodcastFixtures.mockPodcastModelList);

        final result = await repository.searchPodcastBy(
          query: PodcastFixtures.mockQueryValue,
        );

        expect(result, equals(PodcastFixtures.mockPodcastModelList));
        verify(
          () => mockDataSource.searchPodcastBy(
            query: PodcastFixtures.mockQueryValue,
          ),
        ).called(1);
      },
    );

    test(
      'Should rethrow TimeoutException when data source throws it',
      () async {
        when(
          () => mockDataSource.searchPodcastBy(query: any(named: 'query')),
        ).thenThrow(const TimeoutException());

        final result = repository.searchPodcastBy;

        expect(() => result(query: 'test'), throwsA(isA<TimeoutException>()));
      },
    );

    test('Should return the exception when the data source fails', () async {
      when(
        () => mockDataSource.searchPodcastBy(
          query: PodcastFixtures.mockQueryValue,
        ),
      ).thenThrow(Exception('Error Server'));

      expect(
        () => repository.searchPodcastBy(query: PodcastFixtures.mockQueryValue),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getPodcastById', () {
    test(
      'Should return the podcast detail when the data source responds successfully',
      () async {
        when(
          () => mockDataSource.getPodcastBy(
            id: PodcastFixtures.mockPodcastId,
          ),
        ).thenAnswer((_) async => PodcastFixtures.mockPodcastDetail);

        final result = await repository.getPodcastBy(
          id: PodcastFixtures.mockPodcastId,
        );

        expect(result, equals(PodcastFixtures.mockPodcastDetail));
        expect(result.id, PodcastFixtures.mockPodcastId);
        expect(result.episodes.length, 3);
        verify(
          () => mockDataSource.getPodcastBy(
            id: PodcastFixtures.mockPodcastId,
          ),
        ).called(1);
      },
    );

    test(
      'Should rethrow TimeoutException when data source throws it',
      () async {
        when(
          () => mockDataSource.getPodcastBy(id: any(named: 'id')),
        ).thenThrow(const TimeoutException());

        final result = repository.getPodcastBy;

        expect(() => result(id: PodcastFixtures.mockPodcastId),
            throwsA(isA<TimeoutException>()));
      },
    );

    test('Should return the exception when the data source fails', () async {
      when(
        () => mockDataSource.getPodcastBy(
          id: PodcastFixtures.mockPodcastId,
        ),
      ).thenThrow(Exception('Error Server'));

      expect(
        () => repository.getPodcastBy(id: PodcastFixtures.mockPodcastId),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('PodcastRepositoryProvider', () {
    test(
      'Should provide a PodcastRepositoryImpl instance with the correct dependency',
      () {
        final mockDataSource = MockPodcastRemoteDataSource();
        final container = ProviderContainer(
          overrides: [
            podcastRemoteDataSourceProvider.overrideWithValue(mockDataSource),
          ],
        );

        final repository = container.read(podcastRepositoryProvider);

        expect(repository, isA<PodcastRepositoryImpl>());
        container.dispose();
      },
    );
  });
}
