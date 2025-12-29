import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/network/dio_client.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source_impl.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source_provider.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import '../fixtures/podcast_fixtures.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late PodcastRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = PodcastRemoteDataSourceImpl(mockDio);
  });

  group('searchPodcasts', () {
    test(
      'Should return a list of PodcastModel when the response is 200',
      () async {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: PodcastFixtures.mockPodcastResponse,
            statusCode: 200,
            requestOptions: RequestOptions(
              path: PodcastFixtures.mockSearchPath,
            ),
          ),
        );

        final result = await dataSource.searchPodcastBy(
          query: PodcastFixtures.mockQueryValue,
        );

        expect(result, isA<List<PodcastModel>>());
        expect(result.length, 2);
        expect(result[0].id, 'podcast-1');
        expect(result[1].id, 'podcast-2');
        expect(result[1].title, 'The Science Show');
        expect(result[1].id, 'podcast-2');
        expect(result[1].publisher, 'Science Network');
        expect(result[1].imageUrl, 'https://picsum.photos/seed/podcast2/200');
        expect(
          result[1].description,
          'Exploring the wonders of science, from quantum physics to biology.',
        );

        verify(
          () => mockDio.get(
            PodcastFixtures.mockSearchPath,
            queryParameters: {
              PodcastFixtures.mockQueryKey: PodcastFixtures.mockQueryValue,
            },
          ),
        ).called(1);
      },
    );

    test('Should throw an exception when the response fails', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: PodcastFixtures.mockSearchPath),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => dataSource.searchPodcastBy(query: PodcastFixtures.mockQueryValue),
        throwsException,
      );
    });
  });

  group('podcastRemoteDataSourceProvider', () {
    test('Should return a PodcastRemoteDataSourceImpl instance', () {
      final container = ProviderContainer(
        overrides: [dioProvider.overrideWithValue(MockDio())],
      );

      final dataSource = container.read(podcastRemoteDataSourceProvider);

      expect(dataSource, isA<PodcastRemoteDataSourceImpl>());
      container.dispose();
    });
  });
}
