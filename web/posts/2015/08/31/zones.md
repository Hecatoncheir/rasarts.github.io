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

[Zone class](https://api.dartlang.org/1.12.1/dart-async/Zone-class.html)

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

Это универсальное решение и используется часто. Поэтому будет лучше написать для этого отдельную функцию (*wrapper*\):

```language-dart

wrapper(Function body, {Function onError}) {
  try {
    body();
  } on Error catch(e) {
    if (onError != null) {
      onError(e);
    }
  }
}

main() {
  wrapper(runServer, onError:(e) {
    // ...
  });
}

```

Аргумент *body* представляет собой любой код, который находится в блоке *try/catch* внутри *wrapper*. Функция **wrapper** использует функцию *onError* для обработки всех пойманных исключений. Использование **wrapper** - хорошая практика, её использование рекомендуется и в других подобных ситуациях. Это и есть **Zone**.

> **Заметка:** **Zone** это настраиваемый контекст выполнения, который обрабатывает асинхронные задачи и пойманные исключения.

Что зоны могут:

-	в критичных ситуациях, они позволяют обрабатывать исключения правильно
-	дают возможность обработки нескольких асинхронных операций в одной группе
-	могут иметь неограниченное количество вложенных зон

Каждая зона создаёт контекст, вроде защищённой территории, где находится выполняемый код. В дополнение ко всему, зоны имеют локальные переменные и могут определять *microtasks*, создавать одноразовые или повторяющиeся таймеры, выводить информацию, и сохранять *трасировку стека (stack trace)* для отладки.

##Простой пример

Изменим код, для использования зоны вместо функции *wrapper*:

```language-dart

import 'dart:io';
import 'dart:async';

main() {
  runZoned(runServer, onError:(e) {
    // ...
  });
}

```

Функция **runZoned** это обёртка. По умолчанию, библиотека *async* неявно создаёт *root* зону и назначает её статической переменной **current** (read-only) в текущем классе **Zone**. Таким образом, у нас есть активная зона, которая всегда доступна нам в функции **runZoned**. Когда функция **runZoned** запускается, то она порождает новую зону вложенную в *root* и уже внутри этого контекста запускается функция *runServer*. Для создания новой вложенной зоны нужно использовать метод **fork** текущей зоны.

> **Заметка:** Зона может быть создана только с помощью метода **fork** текущей зоны.

<br><br>

##Вложение зон

Допустим мы хотим отдать статичный файл с нашего сервера. Что бы сделать это правильно, мы создадим новую вложенную зону и защитим наш код с помощью функции **runZoned**:

```language-dart

runServer() {
  HttpServer
  .bind(InternetAddress.ANY_IP_V4, 8080)
  .then((server) {
    server.listen((HttpRequest request) {
      runZoned(() {
        readFile(request.uri.path).then((String context){
          request.response.write(context);
          request.response.close();
        });
      }, onError:(e) {
        request.response.statusCode = HttpStatus.NOT_FOUND;
        request.response.write(e.toString());
        request.response.close();
      });
    });
  });
}


Future<String> readFile(String fileName) {
  switch (fileName.trim()) {
    case "/":
    case "/index.html":
    case "/favicon.ico":
      return new Future.sync(() => "Hello, world!");
  }
  return new Future.sync(() =>
      throw new Exception('Resource is not available'));
}

```

Внутри вложенной зоны, мы вызываем функцию **readFile** и передаём в параметре имя ресурса, и уже эта функция возвращает содержание. Если доступа к ресурсу нет, функция *readFile* генерирует исключение, и программа ловит его в функции **onError**, которая зарегистрирована в качестве обработчика ошибок для зоны. Если обработчик ошибок не указан, исключение будет всплывать вверх по иерархии зон пока не обработается в какой-нибудь из родительских зон или не достигнет верхнего уровня и завершит программу.

##Значения зон

Пришло время обсудить аутентификацию на нашем сервере, потому как некоторые ресурсы не должны быть доступны для каждого желающего. Будем следовать идеи аутентификации основанной на токенах (token) которые передаются на сервер с каждым запросом. Мы создадим map *токенов* для того что бы запомнить всех авторизованных клиентов, и затем создадим форк новой зоны для аутентификации. Затем мы будем просматривать токен клиента переданного в заголовке. Когда мы будем получать map токенов из свойства зоны - **current**, мы передадим их в зону с помощью **zoneValues**, как показанно ниже:

```language-dart
runServer() {
  HttpServer
  .bind(InternetAddress.ANY_IP_V4, 8080)
  .then((server) {
    Set tokens = new Set.from(['1234567890']);
    server.listen((HttpRequest request) {
      runZoned((){
        authenticate(request.headers.value('auth-token'));
      }, zoneValues: {'tokens': tokens}, onError:(e){
        request.response.statusCode = HttpStatus.UNAUTHORIZED;
        request.response.write(e.toString());
        request.response.close();
      });

      runZoned(() {
        readFile(request.uri.path).then((String context){
          request.response.write(context);
          request.response.close();
        });
      }, onError:(e) {
        request.response.statusCode = HttpStatus.NOT_FOUND;
        request.response.write(e.toString());
        request.response.close();
      });
    });
  });
}
```

Аутентификация сравнивающая переданный токен с имеющимися выглядит следующим образом:

```language-dart
authenticate(String token) {
  Set tokens = Zone.current['tokens'];
  if (!tokens.contains(token)) {
    throw new Exception('Access denied');
  }
}
```

В предыдущем коде, мы использовали локальные переменные зон (zone-local) для отслеживания токенов и аутентификации клиентов. Переменные были введены в зону с помощью аргумента **zoneValues** функции **runZoned**. Наша переменная *tokens* работает как статичная переменная в асинхронном контексте.

> **Заметка:** Локальные переменные зон могут играть роль статичных переменных доступных только внутри зоны.

Теперь проверим наш код на стороне сервера. Мы установим расширение *Poostman* [http://www.getpostman.com/](http://www.getpostman.com/) для отправления запросов из Dartium. Первый запрос *https://localhost:8080* который мы отправим без *auth-token* вернет *Exception: Access denied*. Этот запрос не был авторизованным потому как отсутствует токен. Добавив его в HTTP заголовки и отправив запрос повторно мы получим строку *Hello, world!* Наш запрос авторизован.
