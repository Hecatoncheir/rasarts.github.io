library in_memory_data_service;

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static Future<Response> _handler(Request request) async {
    Response response;
    String protocol = window.location.protocol;
    String host = window.location.host;

    if (request.method == 'GET') {
      switch (request.url.path) {
        case '/articles/announcements':
          String iri = '$protocol//$host/articles/announcements.json';
          String announcements = await HttpRequest.getString(iri);

          response = new Response(announcements, 200,
              headers: {'content-type': 'application/json'});
          break;
      }
    }

    return response;
  }

  InMemoryDataService() : super(_handler);
}
