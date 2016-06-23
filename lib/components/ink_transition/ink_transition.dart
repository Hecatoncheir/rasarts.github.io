@HtmlImport('ink_transition_theme.html') // Стили компонента
@HtmlImport('ink_transition.html') // Разметка компонента
@JS()
library ink_transition;

import 'dart:html';

import 'package:js/js.dart';

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

import 'package:polymer_elements/marked_element.dart';

@JS('open')
external _open();

@JS('close')
external _close();

@JS('Prism.highlightAll')
external _highlightCode();

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(node) {}
}

@PolymerRegister('ink-transition')
class InkTransition extends PolymerElement {
  open() => _open();
  close() => _close();

  @Property(reflectToAttribute: true)
  String header;

  @Property(reflectToAttribute: true, observer: 'fullDetailsChanged')
  dynamic fullDetails;

  @Property(reflectToAttribute: true, observer: 'detailsChanged')
  dynamic details;

  InkTransition.created() : super.created();

  attached() {
    querySelector('.modal-close').onClick.listen((event) {
      document.dispatchEvent(new CustomEvent('Main page must be open'));
    });
  }

  @reflectable
  void fullDetailsChanged(event, [_]) {
    MarkedElement fullDetailsBlock = querySelector('marked-element');

    if (event == '') {
      fullDetailsBlock.markdown = '';
      return;
    }

    fullDetailsBlock.markdown = event;

    _highlightCode();
  }

  @reflectable
  void detailsChanged(event, [_]) {
    set('details', event);
  }
}
