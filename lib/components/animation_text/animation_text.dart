@HtmlImport('animation_text_theme.html') // Стили компонента
@HtmlImport('animation_text.html') // Разметка компонента
library animation_text;

/// Polymer
import 'package:polymer/polymer.dart';
import 'package:web_components/html_import_annotation.dart' show HtmlImport;

@PolymerRegister('animation-text')
class AnimationText extends PolymerElement {
  AnimationText.created() : super.created();
}
