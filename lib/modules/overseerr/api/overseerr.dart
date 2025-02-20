import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'models.dart';

part 'overseerr.g.dart';

@RestApi()
abstract class Overseerr {
  factory Overseerr({
    required String host,
    required String apiKey,
    Map<String, dynamic> headers = const {},
  }) {
    String _baseUrl = host.endsWith('/') ? '${host}api/v1/' : '$host/api/v1/';
    Dio _dio = Dio(
      BaseOptions(
        headers: {
          'X-Api-Key': apiKey,
          ...headers,
        },
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    return _Overseerr(_dio, baseUrl: _baseUrl);
  }

  @GET('request')
  Future<OverseerrRequestPage> getRequests({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
    @Query('requestedBy') int? requestedBy,
  });

  @GET('request/{id}')
  Future<OverseerrRequest> getRequest({
    @Path('id') required String id,
  });

  @GET('request/count')
  Future<OverseerrRequestCount> getRequestCount();

  @GET('status')
  Future<OverseerrStatus> getStatus();

  @GET('status/appdata')
  Future<OverseerrStatusAppData> getStatusAppData();

  @GET('user')
  Future<OverseerrUserPage> getUsers({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('sort') String? sort,
  });

  @GET('user/{id}')
  Future<OverseerrUserPage> getUser({
    @Path('id') required String id,
  });

  @GET('user/{id}/quota')
  Future<OverseerrUserQuota> getUserQuota({
    @Path('id') required String id,
  });
}
