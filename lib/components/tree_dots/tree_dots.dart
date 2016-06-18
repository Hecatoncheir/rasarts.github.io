@HtmlImport('tree_dots_theme.html') // Стили компонента
@HtmlImport('tree_dots.html') // Разметка компонента
library tree_dots;

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

@PolymerRegister('tree-dots')
class TreeDots extends PolymerElement {
  TreeDots.created() : super.created();
}
