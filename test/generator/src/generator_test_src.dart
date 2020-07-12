import 'dart:io';

import 'package:source_gen_test/annotations.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

@ShouldGenerate(r'''
class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;
''', contains: true)
@RestApi()
abstract class RestClient {}
