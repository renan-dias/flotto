import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ImageTestCall {
  static Future<ApiCallResponse> call({
    String? image = '',
  }) {
    final body = '''
{
  "inputs": [
    {
      "data": {
        "image": {
          "url": "${image}"
        }
      }
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'imageTest',
      apiUrl:
          'https://api.clarifai.com/v2/users/pf7zfb6j2nbk/apps/instagram/models/general-image-recognition/versions/aa7f35c01e0642fda5cf400f543e7c40/outputs',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Key API_KEY_HERE',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic labels(dynamic response) => getJsonField(
        response,
        r'''$.outputs[:].data.concepts[:].name''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
