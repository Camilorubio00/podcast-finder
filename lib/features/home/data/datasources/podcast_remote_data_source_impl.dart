import 'package:dio/dio.dart';
import 'package:podcast_finder/core/network/api_constants.dart';
import 'package:podcast_finder/core/network/api_endpoints.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

class PodcastRemoteDataSourceImpl implements PodcastRemoteDataSource {
  final Dio _dio;

  PodcastRemoteDataSourceImpl(this._dio);

  @override
  Future<List<PodcastModel>> searchPodcastBy({required String query}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.search,
        queryParameters: {ApiConstants.queryKey: query},
      );

      final List<dynamic> results = response.data[ApiConstants.results];

      return results
          .map((podcastJson) => PodcastModel.fromJson(podcastJson))
          .toList();
    } on DioException catch (exception) {
      throw NetworkException.fromDioError(exception);
    } catch (exception) {
      throw Exception('Fails in the search: ${exception.toString()}');
    }
  }
}
