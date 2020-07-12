// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// GenericApiGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  get(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request('/get',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResult<String, User>.fromJson(_result.data,
        fromJson1: (v) => v as String, fromJson2: (v) => User.fromJson(v));
    return value;
  }

  @override
  post(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data =
        data?.toJson(toJson1: (v) => v, toJson2: (User v) => v.toJson()) ??
            <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/post',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResults<User>.fromJson(_result.data,
        fromJson1: (v) => User.fromJson(v));
    return value;
  }

  @override
  list(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(
        data?.toJson(toJson1: (v) => v, toJson2: (User v) => v.toJson()) ??
            <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResults<User>.fromJson(_result.data,
        fromJson1: (v) => User.fromJson(v));
    return value;
  }
}
