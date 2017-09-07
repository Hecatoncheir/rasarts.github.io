library entities;

class Announcement {
  int id;
  String title;
  String text;
  String filePath;
  String icon;
  DateTime date;
  List<String> categories;
  List<String> tags;
}

class Article extends Announcement {
  String announcement;
  String text;
}
