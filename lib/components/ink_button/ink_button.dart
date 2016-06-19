@HtmlImport('ink_button_theme.html') // Стили компонента
@HtmlImport('ink_button.html') // Разметка компонента
library ink_button;

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

@PolymerRegister('ink-button')
class InkButton extends PolymerElement {
  InkButton.created() : super.created();

  @Property(reflectToAttribute: true)
  String name;
}
