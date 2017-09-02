import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static Future<Response> _handler(Request request) async {
    return new Response(JSON.encode({'data': 'test'}), 200,
        headers: {'content-type': 'application/json'});
  }

  InMemoryDataService() : super(_handler);
}
