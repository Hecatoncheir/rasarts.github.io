library router;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:route/client.dart';
import 'package:route/url_pattern.dart';

import 'package:blog/components/ink_transition/ink_transition.dart';

final homeUrl = new UrlPattern(r'/');
final mainPage = new UrlPattern(r'/#');
final articleUrl = new UrlPattern(r'/#article/(\w+)');
final allUrls = [homeUrl, articleUrl];

Router router;
Event loadingPageEvent;
Event readyPageEvent;

InkTransition articleFullContentBlock;

prepareRouter() async {
  loadingPageEvent = new CustomEvent('Page loading');
  readyPageEvent = new CustomEvent('Page ready');

  articleFullContentBlock = await querySelector('ink-transition');

  router = new Router(useFragment: true);

  document.on['Main page must be open'].listen((event){
    router.gotoPath('/#', 'Main page');
  });

  router
    ..addHandler(homeUrl, showHome)
    ..addHandler(mainPage, showHome)
    ..addHandler(articleUrl, showArticle)
    ..listen();
}

showHome(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  articleFullContentBlock.close();
  articleFullContentBlock.set('header', null);
  articleFullContentBlock.set('fullDetails', '');

  document.dispatchEvent(readyPageEvent);
}

showArticle(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  String articleName = articleUrl.parse(path)[0];

  String detailsJSON = await HttpRequest
      .getString('articles/$articleName.json')
      .catchError((error) {
    print(error);
    document.dispatchEvent(readyPageEvent);
    return;
  });

  Map details = JSON.decode(detailsJSON);

  String fullDetailsMD = await HttpRequest
      .getString('articles/$articleName.md')
      .catchError((error) {
    print(error);
    document.dispatchEvent(readyPageEvent);
    return;
  });

  articleFullContentBlock.set('header', details['title']);
  articleFullContentBlock.set('fullDetails', fullDetailsMD);
  articleFullContentBlock.open();

  document.dispatchEvent(readyPageEvent);

  // show article page with loading indicator
  // load article from server, then render article
}
