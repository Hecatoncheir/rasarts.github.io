<!--
title: Isolates
date: 2015/09/22
id: ef101fc8-c1cd-47a2-aa0d-dfbace3d8672
category: Изучение Dart
icon: dart_learning
labels:
  - Dart
  - Isolates
-->

Пришло время обсудить работу нашего сервера. Мы будем использовать HTTP бенчмарк [**wrk**](://github.com/wg/wrk) разработанным Will Glozer. И наш простейший вариант сервера будет выглядеть таким образом:

```language-dart

import 'dart:io';

main() {
  HttpServer
  .bind(InternetAddress.ANY_IP_V4, 8080)
  .then((server) {
    server.listen((HttpRequest request) {
      // Обратный ответ клиенту
      request.response.write('Hello, world!');
      request.response.close();
    });
  });
}

```

Мы проверим этот код с помощью инструмента бенчмаркинга и сохраним 512 одновременных подключений которые будут открытыми в течении 30 секунд:

```language-bash
wrk -t1 -c256 -d30s http://127.0.0.1:8080/
```

Вот результат выполнения предыдущего кода:

```language-bash

Running 30s test @ http://127.0.0.1:8080
  1 threads and 256 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    33.89ms   24.51ms 931.37ms   99.76%
    Req/Sec     7.63k   835.29     9.77k    89.93%
  225053 requests in 30.00s, 15.02MB read
Requests/sec:   7501.81
Transfer/sec:    512.82KB

```

Тест показал что наш сервер способен обрабатывать приблизительно 7500 запросов в секунду. На самом деле это не так уж и плохо. Можно ли улучшить это значение? Ключевой проблемой является то, что вся эта работа осуществлялась в одном потоке:

 - Один поток обрабатывает все клиенты, которые появляются в одном месте
 - Все работы будут выполняться последовательно в одном потоке
