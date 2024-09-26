import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../domain/repositories/database/local_database_repository.dart';
import '../api_status.dart';
import '../file_field.dart';
import '../network_repository.dart';

class DioNetworkRepository implements NetworkRepository {
  /// localhost
  String baseUrl = "http://localhost:5000";

  final LocalDatabaseRepository _localDatabaseRepository;

  DioNetworkRepository(this._localDatabaseRepository);

  var dio = Dio();

  initialize() {
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: false,
      responseHeader: false,
      error: true,
      maxWidth: 90,
    ));
  }

  @override
  Future<dynamic> sendRequest(
      final String endpoint, {
        final NetworkRequestMode mode = NetworkRequestMode.get,
        final Map<String, dynamic> parameters=const {},
        final Map<String, dynamic> body=const {},
        final bool isFormData = false,
        final bool getAllResponse = false,
        final List<FileField>? fileFields,
  }) async {
    try {
      var headers = isFormData
          ? {'Content-Type': 'multipart/form-data'}
          : {'Content-Type': 'application/json'};
      headers.addAll({
        "Authorization": "Bearer ${await _localDatabaseRepository.getToken()}"
      });

      String method = '';
      switch (mode) {
        case NetworkRequestMode.post:
          method = 'POST';
          break;
        case NetworkRequestMode.get:
          method = 'GET';
          break;
        case NetworkRequestMode.delete:
          method = 'DELETE';
          break;
        // Add cases for other HTTP methods as needed
        default:
          throw Exception('Unsupported HTTP method: $mode');
      }

      if (fileFields != null && fileFields.isNotEmpty) {
        body.addAll(await _getFileFields(fileFields));
      }

      Response response = await dio.request(
        '$baseUrl$endpoint',
        queryParameters: _removeNullAndEmptyValues(parameters),
        options: Options(
          method: method,
          headers: headers,
        ),
        data: isFormData?FormData.fromMap(body):body,
      );

      dynamic responseJson = await response.data;
      return getAllResponse ? responseJson : responseJson['data'];
    } on DioException catch (e) {
      _handleException(e);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future<Map<String, dynamic>> _getFileFields(
      List<FileField> fileFields) async {
    Map<String, dynamic> mediaFields = {};
    for (var fileFiled in fileFields) {
      List<MultipartFile> multipartFiles = [];
      debugPrint(
          "We have field : ${fileFiled.fieldName}, and files: ${fileFiled.files}");
      for (var httpFile in fileFiled.files) {
        debugPrint(
            "image path : ${httpFile.path}, FILE NAME : ${basename(httpFile.path)}");
        // Determine MIME type dynamically based on file extension
        String mimeType =
            lookupMimeType(httpFile.path) ?? 'application/octet-stream';
        MultipartFile multipartFile = await MultipartFile.fromFile(
          httpFile.path,
          filename: httpFile.path.split('/').last,
          // contentType: MediaType.parse(mimeType),
        );
        multipartFiles.add(multipartFile);
      }
      mediaFields.addAll({fileFiled.fieldName: multipartFiles});
    }
    return mediaFields;
  }

  _handleException(DioException exception) {
    debugPrint("status code : ${exception.response?.statusCode}");
    if (exception.type == DioExceptionType.connectionError) {
      throw ApiStatuses.INTERNET_CONNECTION_PROBLEM;
    }
    throw exception.response?.data['message'];
  }

  Map<String, dynamic> _removeNullAndEmptyValues(
      Map<String, dynamic> inputMap)  {
    return Map.from(inputMap)
      ..removeWhere(
          (key, value) => value == null || (value is String && value.isEmpty));
  }
}
