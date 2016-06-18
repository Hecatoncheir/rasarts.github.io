@HtmlImport('stack_pages_theme.html') // Стили компонента
@HtmlImport('stack_pages.html') // Разметка компонента
library stack_pages;

import 'dart:html';
import 'dart:async';

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

/// Components
import 'package:blog/components/tree_dots/tree_dots.dart';

@PolymerRegister('stack-pages')
class StackPages extends PolymerElement {
  StackPages.created() : super.created();

  attached(){
//    Event readyPageEvent = new CustomEvent('Page ready');
//    new Timer(new Duration(seconds: 2),(){
//      document.dispatchEvent(readyPageEvent);
//    });
  }
}
