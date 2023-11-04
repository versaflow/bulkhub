import 'dart:convert';
import 'package:bulkhub/core/data/datasources/remote_data_source.dart';
import 'package:bulkhub/core/error/exception.dart';
import 'package:bulkhub/core/remote_urls.dart';
import 'package:bulkhub/modules/authentication/models/user_login_response_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'mock_data/mock_data_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late RemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: http.Client());
  });

  // group("Auth apis user validation", () {
  //   test("user Login seccess", () async {
  //     expect(await dataSource.signIn(userInfoMockMap), equals(mockDataModel));
  //   });
  //   test("user Login ServerException", () async {
  //     expect(() => dataSource.signIn(emailErrorData),
  //         throwsA(isA<ServerException>()));
  //   });
  //   test("user Login UnauthorisedException", () async {
  //     expect(() => dataSource.signIn(emailErrorData),
  //         throwsA(isA<UnauthorisedException>()));
  //   });
  //   test("user Login InvalidInputException", () async {
  //     expect(() => dataSource.signIn(passwordErrorData),
  //         throwsA(isA<InvalidInputException>()));
  //   });
  // });
  group("Auth apis login", () {
    final userInfoMockMap = {"email": "user1@gmail.com", "password": "1234"};
    final emailErrorData = {"email": "omar@gmail.com", "password": "1234"};
    final passwordErrorData = {"email": "user1@gmail.com", "password": "12344"};
    const mockdataUrl = 'user_login.json';
    final testJson = mockDataReader(mockdataUrl);
    // final mockData = json.encode(testJson);
    final mockDataModel = UserLoginResponseModel.fromJson(testJson);
    test("user Login seccess", () async {
      expect(await dataSource.signIn(userInfoMockMap), equals(mockDataModel));
    });
    test("user Login ServerException", () async {
      expect(() => dataSource.signIn(emailErrorData),
          throwsA(isA<ServerException>()));
    });
    test("user Login UnauthorisedException", () async {
      expect(() => dataSource.signIn(emailErrorData),
          throwsA(isA<UnauthorisedException>()));
    });
    test("user Login InvalidInputException", () async {
      expect(() => dataSource.signIn(passwordErrorData),
          throwsA(isA<InvalidInputException>()));
    });
  });
  group("Auth apis registration", () {
    final userInfoMockMap = {
      "email": "admin@gmail.com",
      "password": "1234",
      "password_confirmation": "1234",
      "agree": "1",
      "name": "demo name"
    };
    final successData = {
      "email": "gjf@gmail.com",
      "password": "1234",
      "password_confirmation": "1234",
      "agree": "1",
      "name": "demo name"
    };
    // const mockdataUrl = 'user_register.json';
    // final testJson = mockDataReader(mockdataUrl);
    // final userData = json.encode(testJson);

    test("user userRegister ServerException", () async {
      // final uri = Uri.parse(RemoteUrls.userRegister);
      // arrange
      // final response = MockResponse();
      // when(() => response.statusCode).thenReturn(422);
      // when(() => response.body).thenReturn(userData);
      // when(() => mockHttpClient.post(uri, body: userInfoMockMap))
      //     .thenAnswer((_) async => response);

      // print(response.body);
      // print(response.statusCode);

      expect(() => dataSource.userRegister(userInfoMockMap),
          throwsA(isA<ServerException>()));
    });
    test("user userRegister InvalidInputException", () async {
      expect(() => dataSource.userRegister(userInfoMockMap),
          throwsA(isA<InvalidInputException>()));
    });
    test("user userRegister Success message", () async {
      final result = await dataSource.userRegister(successData);
      expect(result, equals("Register Successfully. Please Verify your email"));
    });
  });

  group("home api", () {
    const mockdataUrl = 'home_data.json';
    final testJson = mockDataReader(mockdataUrl);
    final userData = json.decode(testJson);
    test("home api call ", () async {
      final uri = Uri.parse(RemoteUrls.homeUrl);
      // arrange
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(testJson);
      when(() => mockHttpClient.get(uri)).thenAnswer((_) async => response);

      final result = dataSource.getHomeData;

      // print(result.toString().length);
      // print(userData.toString().length);

      expect(userData, equals(result));
    });
  });
}
