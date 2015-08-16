<!--
title: Отправка и полу&shy;че&shy;ние дан&shy;ных с помощ&shy;ью web&shy;sockets
date: 2014/09/7
id: 31c0e4cf-3819-4df5-89e0-7b4c627706f5
category: Примеры кода Dart
icon: dart_tutorial
next_post: posts/2014/09/07/HTTP_clients_and_servers.html
prev_post: posts/2015/08/05/The_Dart_Vm_execution_model.html
labels:
  - Dart
  - WebSocket
-->

WebSocket позволяет приложениям обмениваться данными с сервером в интерактивном режиме без необходимости создавать запрос каждый раз. Сервер создает WebSocket и слушает запросы на определенном URL, который начинается с `ws://` - к примеру, `ws://127.0.0.1:1337/ws`. Данные передаваемые по WebSocket могут быть строками, blob или [ArrayBuffer](http://api.dartlang.org/html/ArrayBuffer.html). Чаще всего данные передаются строками в формате JSON.

Чтобы использовать WebSocket в приложении, нужно создать объект [WebSocket](http://api.dartlang.org/html/WebSocket.html), передав ему первым параметром URL:

```language-dart
var ws = new WebSocket('ws://echo.websocket.org');
```

Отправка данных
---------------

Для отправки данных по WebSocket используется метод `send()`:

```language-dart
ws.send('Hello from Dart!');
```

Прием данных
------------

Для получения данных по WebSocket задается прослушка события `message`:

```language-dart
ws.onMessage.listen((MessageEvent e) {
  print('Полученное сообщение: ${e.data}');
});
```

Обработчик события `message` получает объект `MessageEvent`. Данные, принятые с сервера, находятся в свойстве `data` объекта `MessageEvent`.

Работа с событиями WebSocket
----------------------------

Ваше приложение может прослушивать следующие события WebSocket: `open`, `close`, `error` и (как показано выше) `message`. Ниже показан пример метода который создает объекта WebSocket и добавляет к нему обработчики событий `open`, `close`, `error`, и `message`.

```language-dart
void initWebSocket([int retrySeconds = 2]) {
  var reconnectScheduled = false;

  print("Подключение к websocket");
  ws = new WebSocket('ws://echo.websocket.org');

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      new Timer(new Duration(milliseconds: 1000 * retrySeconds),
                () => initWebSocket(retrySeconds * 2));
    }
    reconnectScheduled = true;
  }

  ws.onOpen.listen((e) {
    print('Подключено');
    ws.send('Hello from Dart!');
  });

  ws.onClose.listen((e) {
    print('Websocket закрыт, повторная отправка через  $retrySeconds секунд');
    scheduleReconnect();
  });

  ws.onError.listen((e) {
    print("Ошибка подключения к ws");
    scheduleReconnect();
  });

  ws.onMessage.listen((MessageEvent e) {
    print('Получено сообщение: ${e.data}');
  });
}
```

Больше информации и примеров использования WebSocket приведено в [Dart Code Samples](http://www.dartlang.org/samples/).
