library articles;

import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:angular/angular.dart';
import 'package:pages/src/entities.dart';

@Injectable()
class ArticlesService {
  Client client;

  ArticlesService(this.client);

  Future<List<Announcement>> getAllAnnouncements() async {
    Response response = await client.get('/articles/announcements');

    List<Map<String, String>> allAnnouncements = JSON.decode(response.body);

    List<Announcement> records = new List<Announcement>();

    for (Map<String, String> record in allAnnouncements) {
      int id = int.parse(record['id']);
      String title = record['title'];
      String text = record['text'];
      String filePath = record['filePath'];
      DateFormat format = new DateFormat("y/M/d");
      DateTime date = format.parse(record['date']);
      List<String> tags = record['tags'] as List<String>;

      Announcement announcement = new Announcement(
          id: id,
          title: title,
          text: text,
          filePath: filePath,
          date: date,
          tags: tags);

      records.add(announcement);
    }

    return records;
  }
}
