library w3guru;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

part 'navigation.dart';
part 'vim_nav.dart';
part 'touch_events.dart';

main(){
  // var copyPath = querySelector('.copy-path');
  makeVimNavigation();
  makePostsNavigation();
  activatePost(posts.first);
  checkPrevPost();
}
