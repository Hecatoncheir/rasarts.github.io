library application_component;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:pages/components.dart';

@Component(
    selector: 'application',
    templateUrl: 'application.html',
    directives: const [
      ROUTER_DIRECTIVES
    ],
    providers: const [
      ROUTER_PROVIDERS,
      const Provider(LocationStrategy, useClass: HashLocationStrategy)
    ])
@RouteConfig(const [
//  const Route(path: '/', name: "Home", component: HomeComponent),
//  const Route(path: 'about', name: "About", component: AboutMeComponent)
])
class ApplicationComponent {}
