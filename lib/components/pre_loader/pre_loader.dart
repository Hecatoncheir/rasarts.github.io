@HtmlImport('pre_loader.html') // Разметка компонента
@JS('preLoader')
library pre_loader;

import 'dart:html';
import 'package:js/js.dart';

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

@JS('init')
external preLoaderInit();

@JS('spinner.setComplete')
external preLoaderClose();

@PolymerRegister('pre-loader')
class PreLoader extends PolymerElement {
  PreLoader.created() : super.created();

  ready(){
    document.addEventListener('Page loading', (CustomEvent e) {
      preLoaderInit();
    });

    document.addEventListener('Page ready', (CustomEvent e) {
      preLoaderClose();
    });
  }

}
