library w3guru;

import 'dart:html';
import 'dart:async';

part 'navigation.dart';
part 'vim_nav.dart';

main(){
  // var copyPath = querySelector('.copy-path');
  makeVimNavigation();
  makePostsNavigation();
  activatePost(posts.first);
  checkPrevPost();
}
