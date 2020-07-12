import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'api_result.dart';
import 'user.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio _dio, {String baseUrl}) = _RestClient;

  @GET("/get")
  Future<ApiResult<String, User>> get(@Body() Map<String, dynamic> data);

  @POST("/post")
  Future<ApiResults<User>> post(@Body() ApiResult<String, User> data);

  @GET("/list")
  Future<ApiResults<User>> list(@Queries() ApiResult<String, User> data);

}
