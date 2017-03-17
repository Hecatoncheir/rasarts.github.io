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
final aboutUrl = new UrlPattern(r'/#about');
final codeUrl = new UrlPattern(r'/#code');
final articleUrl = new UrlPattern(r'/#article/(\w+)');
final tagUrl = new UrlPattern(r'/#tag/(\w+)');
final categoryUrl = new UrlPattern(r'/#category/(\w+)');
final allUrls = [homeUrl, articleUrl];

Router router;
Event loadingPageEvent;
Event readyPageEvent;

InkTransition articleFullContentBlock;
Map articles;
Map articleDetails;

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
    ..addHandler(aboutUrl, showAboutMePage)
    ..addHandler(codeUrl, showMyCodePage)
    ..addHandler(homeUrl, showHome)
    ..addHandler(mainPage, showHome)
    ..addHandler(articleUrl, showArticle)
    ..addHandler(tagUrl, showTagPage)
    ..addHandler(categoryUrl, showCategoryPage)
    ..listen();
}

Element pageHome;
Element pageExamplesCode;
Element pageGuidelinesForAction;
Element pageLearningDart;
Element pageTagGo;
Element pageTagHTTP;

prepareAllPages() async {
  pageHome = querySelector('#page-home');
  pageExamplesCode = querySelector('#page-examples-Dart-code');
  pageGuidelinesForAction = querySelector('#page-guidelines-for-action');
  pageLearningDart = querySelector('#page-learning-Dart');
  pageTagGo = querySelector('#page-tag-Go');
  pageTagHTTP = querySelector('#page-tag-HTTP');

  String articlesJSON = await HttpRequest.getString('/articles/articles.json');
  Map originalArticles = JSON.decode(articlesJSON);
  articles = new Map();

  originalArticles.keys.toList().reversed.forEach((String articleName) {
    articles[articleName] = originalArticles[articleName];
  });

  for (int articleId = 0; articleId < articles.values.length; articleId++) {
    String category = articles.values.toList()[articleId];
    String article = articles.keys.toList()[articleId];

    String articleDetailsJSON =
        await HttpRequest.getString('/articles/$category/$article.json');

    articleDetails = JSON.decode(articleDetailsJSON);

    String template = '''
         <header class="bp-header cf style-scope stack-pages">

            <span class="bp-header__present style-scope stack-pages">${articleDetails['tags']}</span>
            <a class="style-scope stack-pages" href="/#article/${article}">
              <h1 class="bp-header__title style-scope stack-pages">${articleDetails['title']}</h1>
            </a>
            <p class="bp-header__desc style-scope stack-pages">${articleDetails['category']}</p>

        </header>
        ''';

    pageHome.appendHtml(template, treeSanitizer: new NullTreeSanitizer());

    if (articleDetails['category'] == 'Примеры кода Dart') {
      await pageExamplesCode.appendHtml(template,
          treeSanitizer: new NullTreeSanitizer());
    }

    if (articleDetails['category'] == 'Руководство к действию') {
      await pageGuidelinesForAction.appendHtml(template,
          treeSanitizer: new NullTreeSanitizer());
    }

    if (articleDetails['category'] == 'Изучение Dart') {
      await pageLearningDart.appendHtml(template,
          treeSanitizer: new NullTreeSanitizer());
    }

    if (articleDetails['tags'].contains('Go')) {
      await pageTagGo.appendHtml(template,
          treeSanitizer: new NullTreeSanitizer());
    }

    if (articleDetails['tags'].contains('HTTP')) {
      await pageTagHTTP.appendHtml(template,
          treeSanitizer: new NullTreeSanitizer());
    }
  }
}

showHome(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  articleFullContentBlock.close();
  articleFullContentBlock.set('header', null);
  articleFullContentBlock.set('fullDetails', '');

  if (articleDetails == null ||
      articleDetails.isEmpty ||
      articles == null ||
      articles.isEmpty) {
    await prepareAllPages();
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

showTagPage(String path) async {
  await document.dispatchEvent(loadingPageEvent);
  String tagName = tagUrl.parse(path)[0];

  document.dispatchEvent(readyPageEvent);
}

showCategoryPage(String path) async {
  await document.dispatchEvent(loadingPageEvent);
  String categoryName = categoryUrl.parse(path)[0];

  await prepareAllPages();

  if (categoryName == 'examples_Dart_code') {
    querySelector('[href="#${pageExamplesCode.id}"').click();
  }

  if (categoryName == 'guidelines_for_action') {
    querySelector('[href="#${pageGuidelinesForAction.id}"').click();
  }

  if (categoryName == 'learning_Dart') {
    querySelector('[href="#${pageLearningDart.id}"').click();
  }

  document.dispatchEvent(readyPageEvent);
}

showAboutMePage(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  String aboutMeMD = await HttpRequest.getString('/articles/$path.md');

  articleFullContentBlock.set('header', 'Востриков Виталий');
  articleFullContentBlock.set('fullDetails', aboutMeMD);
  articleFullContentBlock.open();

  document.dispatchEvent(readyPageEvent);
}

showMyCodePage(String path) async {
  await document.dispatchEvent(loadingPageEvent);

  String codeMD = await HttpRequest.getString('/articles/$path.md');

  articleFullContentBlock.set('header', 'Примеры и пакеты');
  articleFullContentBlock.set('fullDetails', codeMD);
  articleFullContentBlock.open();

  document.dispatchEvent(readyPageEvent);
}
