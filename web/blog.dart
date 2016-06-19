library blog;

import 'dart:html';

/// Polymer
import 'package:polymer/polymer.dart';

/// Components
import 'package:blog/components/pre_loader/pre_loader.dart';
import 'package:blog/components/stack_pages/stack_pages.dart';

main() async {
  await initPolymer();

  window.onLoad.listen((e) {
    Event readyPageEvent = new CustomEvent('Page ready');
    document.dispatchEvent(readyPageEvent);
  });
}
