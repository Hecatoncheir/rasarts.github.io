<!--
title: Установка Dart в C9
date: 2015/08/12
id: 7721726f-651a-48b1-94d3-c53977308c1b
labels:
  - Dart
  - C9
-->

[Dartlang.org](http://www.dartlang.org/tools/debian.html) - тут есть небольшая информация. Отсюда делаем следующее:

```language-bash
$ sudo apt-get update
$ sudo apt-get install apt-transport-https
$ sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
$ sudo sh -c 'curlhttps://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
$ sudo apt-get update
и
$ sudo apt-get install dart
```

На этом этапе Dart уже установлен, но пользоваться pub еще нельзя. Что бы это исправить: Смотрим сюда: [Dartlang.org](https://www.dartlang.org/tools/pub/installing.html)

Нужно узнать где и что лежит, для этого:

```language-bash
$dpkg -L 'dart' ищем путь к папке 'bin' для пакета dart (что-то похожее на: /usr/lib/dart/bin) и можно указать путь для pub:
$export PATH=${PATH}:/usr/lib/dart/bin
```

Теперь команда pub работает, но только для этой сессии. Что бы команда pub работала всегда, запишем этот путь в ~/.profile :

```language-bash
 $vim ~/.profile спускаемся в низ и жмем "i", вводим: $export PATH=${PATH}:/usr/lib/dart/bin потом "esc" затем ":" и "x" и "enter"
```

Все, теперь все работает, и dart и pub не вываливаются после перезагрузки сессии.
