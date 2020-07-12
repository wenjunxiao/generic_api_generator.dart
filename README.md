# generic_api_generator

Fork from [retrofit_generator](https://github.com/trevorwang/retrofit.dart), adapt to [generic_json_serializable](https://github.com/wenjunxiao/generic_json_serializable.dart), Automatically generate api calling code, which has custom generic class.

```dart
@RestApi()
abstract class UserClient {
  factory UserClient(Dio dio) = _UserClient;

  @POST("/api/login")
  Future<ApiResult<String, User>> login(@Body() Map<String, dynamic> data);

  @GET("/api/users")
  Future<ApiResults<User>> getUsers(@Queries() ApiResult<String, User> data);
}
```

  Fix use `fromJson` to decoder a type has geneic parameters.
```dart
class _UserClient implements UserClient {
  _UserClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  login(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResult<String, User>.fromJson(_result.data,
        fromJson1: (v) => v as String, fromJson2: (v) => User.fromJson(v));
    return value;
  }
}
```


 