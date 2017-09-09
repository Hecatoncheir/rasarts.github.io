library entities;

class Announcement {
  int id;
  String title;
  String text;
  String filePath;
  DateTime date;
  List<String> tags;

  Announcement(
      {this.id, this.title, this.text, this.filePath, this.date, this.tags});
}

class Article extends Announcement {
  int id;
  String announcement;
  String title;
  String text;
  String filePath;
  DateTime date;
  List<String> tags;

  Article(
      {this.id,
      this.announcement,
      this.title,
      this.text,
      this.filePath,
      this.date,
      this.tags});
}
