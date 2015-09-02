<!--
title: Zones
date: 2015/08/31
id: e958b17d-651a-4739-a24e-c0ea6114f2d8
category: Изучение Dart
icon: dart_learning
labels:
  - Dart
  - Zones
-->

Часто, программа генерирует не перехваченное исключение и прекращает выполнение. Это может означать что код работает не правильно и его нужно исправить. Но иногда исключения могут происходить по ошибке коммуникации, аппаратных сбоев и тому подобное. Для демонстрации проблемы, используем *HTTP* сервер в качестве примера:

```language-dart

import 'dart:io';

main() {
  runServer();
}

runServer() {
  HttpServer
  .bind(InternetAddress.ANY_IP_V4, 8080)
  .then((server) {
    server.listen((HttpRequest request) {
      request.response.write('Hello, world!');
      request.response.close();
    });
  });
}

```

В случае возникновения ошибок в функции *runServer*, выполнение кода в главной функции *main* может быть остановлено. Завершение программы в таких случаях может быть не желательно.

Как можно решить эту проблему? Мы можем обернуть наш код в блок **try/catch** и перехватить все исключения, и тогда всё будет работать отлично:

```language-dart

main() {
  try {
    runServer();
  } on Error catch(e) {
    // ...
  } 
}

```
