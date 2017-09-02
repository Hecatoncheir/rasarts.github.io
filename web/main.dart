import 'package:angular/angular.dart';
import 'package:http/http.dart';

import 'package:pages/in_memory_data_service.dart';
import 'package:pages/components.dart';

void main() {
  bootstrap(
      ApplicationComponent, [provide(Client, useClass: InMemoryDataService)]);
}
