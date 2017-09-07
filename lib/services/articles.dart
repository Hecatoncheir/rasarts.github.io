library articles;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:angular/angular.dart';
import 'package:pages/src/entities.dart';

@Injectable()
class ArticlesService {
  Client client;

  ArticlesService(this.client);

  Future<List<Article>> getAllAnnouncements() async {
    Response response = await client.get('/articles/announcements');

    print(response);

    List<Map<String, String>> allAnnouncements = JSON.decode(response.body);

    List<Article> records = new List<Article>();

    for (Map<String, String> announcementRecording in allAnnouncements) {
      Article record = new Article();
      record.announcement = announcementRecording['announcement'];
      records.add(record);
    }

    return records;
  }
}
