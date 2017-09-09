library home_component;

import 'package:angular/angular.dart';
import 'package:pages/services.dart';
import 'package:pages/src/entities.dart';

@Component(
    selector: 'home',
    templateUrl: 'home.html',
    providers: const [ArticlesService])
class HomeComponent implements OnInit {
  ArticlesService articlesService;

  HomeComponent(this.articlesService);

  void ngOnInit() {
    articlesService
        .getAllAnnouncements()
        .then((List<Announcement> announcements) {
      print(announcements[0].text);
    });
  }
}
