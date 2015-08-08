<!--
title: Dart VM модель исполнения
date: 2015/08/05
id: 451b37a7-b826-408d-adbc-84cb7bfc9bd4
status: Готовится к публикации
not_ready: false
labels:
  - Dart
-->

Dart использует событийно-ориентированную архитектуру, основанной на однопоточной модели выполнения с одним **циклом событий** и двумя очередями. Dart все еще поддерживает стек вызова. Тем не менее, для передачи контекста между производящим кодом и выполняющим используются события. Цикл событий (event loop) основывается на одном потоке, так что ничего синхронизировать и лочить не нужно.

**Заметка**

> Цикл событий блокируется с запуском операций блокирующих все приложение.