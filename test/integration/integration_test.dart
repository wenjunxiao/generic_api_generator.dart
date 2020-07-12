import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:test/test.dart';
import 'api_result.dart';
import 'rest_client.dart';
import 'user.dart';

class UserMatcher extends Matcher {
  final User expected;
  UserMatcher(this.expected);
  @override
  Description describe(Description description) {
    return description;
  }

  @override
  bool matches(desc, Map matchState) {
    if (desc is User) {
      // 或者重写
      // class User {
      //   bool operator ==(o) => o is User && o.uid == uid && o.name == name;
      //   int get hashCode => hash2(uid.hashCode, name.hashCode);
      // }
      return desc.uid == expected.uid && desc.name == expected.name;
    }
    return false;
  }
}

class ApiResultMatcher extends Matcher {
  final ApiResult<String, User> expected;
  ApiResultMatcher(this.expected);
  @override
  Description describe(Description description) {
    return description;
  }

  @override
  bool matches(desc, Map matchState) {
    if (desc is ApiResult<String, User>) {
      // 或者重写
      // class ApiResult {
      //   bool operator ==(o) => o is ApiResult && o.success == success && o.error == error && o.data == data;
      //   int get hashCode => hash3(success.hashCode, error.hashCode, data.hashCode);
      // }
      // class User {
      //   bool operator ==(o) => o is User && o.uid == uid && o.name == name;
      //   int get hashCode => hash2(uid.hashCode, name.hashCode);
      // }
      return desc.success == expected.success &&
          desc.error == expected.error &&
          desc.data.uid == expected.data.uid &&
          desc.data.name == expected.data.name;
    }
    return false;
  }
}

MockWebServer _server;
RestClient _client;
final _headers = {"Content-Type": "application/json"};
final dispatcherMap = <String, MockResponse>{};

void main() async {
  setUp(() async {
    _server = MockWebServer();
    await _server.start();
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    _client = RestClient(dio, baseUrl: _server.url);
  });

  tearDown(() {
    _server.shutdown();
  });

  test("test get", () async {
    _server.enqueue(
        body: jsonEncode({
          'success': true,
          'error': 'no error',
          'data': {'uid': 'test_uid', 'name': 'test_name'}
        }),
        headers: {"Content-Type": "application/json"});
    ApiResult<String, User> result = await _client.get({});
    expect(result, isNotNull);
    expect(
        result,
        ApiResultMatcher(ApiResult<String, User>(
            true, 'no error', User('test_uid', 'test_name'))));
  });

  test("test post", () async {
    _server.enqueue(
        body: jsonEncode({
          'success': true,
          'error': 'no error',
          'data': [
            {'uid': 'test_uid', 'name': 'test_name'}
          ]
        }),
        headers: {"Content-Type": "application/json"});
    ApiResults<User> result = await _client.post(ApiResult<String, User>(
        true, 'no error', User('test_uid', 'test_name')));
    expect(result, isNotNull);
    for (var user in result.data) {
      expect(user, UserMatcher(User('test_uid', 'test_name')));
    }
  });

  test("test list", () async {
    _server.enqueue(
        body: jsonEncode({
          'success': true,
          'error': 'no error',
          'data': [
            {'uid': 'test_uid', 'name': 'test_name'}
          ]
        }),
        headers: {"Content-Type": "application/json"});
    ApiResults<User> result = await _client.list(ApiResult<String, User>(
        true, 'no error', User('test_uid', 'test_name')));
    expect(result, isNotNull);
    for (var user in result.data) {
      expect(user, UserMatcher(User('test_uid', 'test_name')));
    }
  });
}
