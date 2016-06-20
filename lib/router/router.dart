library router;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:route/client.dart';
import 'package:route/url_pattern.dart';

import 'package:blog/components/ink_transition/ink_transition.dart';

import 'package:polymer/polymer.dart';

final homeUrl = new UrlPattern(r'/');
final mainPage = new UrlPattern(r'/#');
final articleUrl = new UrlPattern(r'/#article/(\w+)');
final allUrls = [homeUrl, articleUrl];

Router router;
Event loadingPageEvent;
Event readyPageEvent;

InkTransition articleFullContentBlock;
Map articles;

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(node) {}
}

prepareRouter() async {
  loadingPageEvent = new CustomEvent('Page loading');
  readyPageEvent = new CustomEvent('Page ready');

  articleFullContentBlock = await querySelector('ink-transition');

  router = new Router(useFragment: true);

  document.on['Main page must be open'].listen((event) {
    router.gotoPath('/#', 'Vitaliy Vostrikov Blog');
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

  Element pageHome = querySelector('#page-home');

  if (articles == null || articles.isEmpty) {
    String articlesJSON =
        await HttpRequest.getString('/articles/articles.json');
    articles = JSON.decode(articlesJSON);

    print(articles);
    print(articles.values.length);

    for (int articleId = 0; articleId < articles.values.length; articleId++) {
      String category = articles.values.toList()[articleId];
      String article = articles.keys.toList()[articleId];

      String articleDetailsJSON =
          await HttpRequest.getString('/articles/$category/$article.json');

      Map articleDetails = JSON.decode(articleDetailsJSON);
      print(articleDetails);

      if (articleId < 5) {
        pageHome.appendHtml(
            '''
         <header class="bp-header cf style-scope stack-pages">

            <a href="/#article/$article">
                <ink-button class="ink-btn style-scope stack-pages">Открыть</ink-button>
            </a>

            <span class="bp-header__present style-scope stack-pages">${articleDetails['tags']}</span>
            <a class="style-scope stack-pages" href="/#article/${article}">
              <h1 class="bp-header__title style-scope stack-pages">${articleDetails['title']}</h1>
            </a>
            <p class="bp-header__desc style-scope stack-pages">${articleDetails['category']}</p>

        </header>
        ''',
            treeSanitizer: new NullTreeSanitizer());
      }
    }
  }

  document.dispatchEvent(readyPageEvent);
}

/// Show some article
showArticle(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  String articleName = articleUrl.parse(path)[0];
  String category;

  if (articles == null || articles.isEmpty) {
    String articlesJSON =
        await HttpRequest.getString('/articles/articles.json');
    articles = JSON.decode(articlesJSON);
  }

  articles.forEach((String articleLink, String categoryName) {
    if (articleLink == articleName) {
      category = categoryName;
    }
  });

  String detailsJSON = await HttpRequest
      .getString('articles/$category/$articleName.json')
      .catchError((error) {
    print(error);
    document.dispatchEvent(readyPageEvent);
    return;
  });

  Map details = JSON.decode(detailsJSON);

  String fullDetailsMD = await HttpRequest
      .getString('articles/$category/$articleName.md')
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
