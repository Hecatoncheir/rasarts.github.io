@HtmlImport('ink_transition_theme.html') // Стили компонента
@HtmlImport('ink_transition.html') // Разметка компонента
library ink_transition;

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

@PolymerRegister('ink-transition')
class InkTransition extends PolymerElement {
  InkTransition.created() : super.created();

  @Property(reflectToAttribute: true)
  String header;
}
