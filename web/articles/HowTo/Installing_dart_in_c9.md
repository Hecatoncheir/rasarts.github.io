[Dartlang.org](http://www.dartlang.org/tools/debian.html) - тут есть информация.

Нужно иметь возможность запускать проекты написанные на Dart, а так же прогонять backend и клиентские тесты.

Для решения этой задачи понадобится скачать архив с dart-sdk для Linux дистрибутива сам Dartium и Content-shell. Т.к. нужно запускать и клиентские тесты тоже, для этого пригодится xvfb которая позволит запускать Dartium и выводить содержание его консоли прямо в терминал.

## Установка необходимых пакетов

Т.к. будет запускаться Dartium, который в свою очередь построен на Chrome, то и зависимости нужны будут такие как у браузера Chrome.
Можно упростить поиски зависимостей и поставить Chrome следующим образом:

### Ключ и репозиторий для установки Chrome:
```bash
curl -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
```

### Установка пакетов:
```bash
apt-get -y -f install git xvfb  unzip apt-transport-https google-chrome-stable --allow-unauthenticated && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /download/directory
```

## Установка Dartium
```bash
cd ~
curl http://gsdview.appspot.com/dart-archive/channels/stable/release/1.17.1/dartium/dartium-linux-x64-release.zip && unzip dartium-linux-x64-release.zip && rm dartium-linux-x64-release.zip && mv dartium-lucid64-full-stable-1.17.1.0 dartium && mv dartium/chrome dartium/dartium
```

## Установка ContentShell
```bash
cd ~
curl http://gsdview.appspot.com/dart-archive/channels/stable/release/1.17.1/dartium/content_shell-linux-x64-release.zip && unzip content_shell-linux-x64-release.zip && rm content_shell-linux-x64-release.zip && mv drt-lucid64-full-stable-1.17.1.0 content_shell
```

## Установка Dart SDK
```bash
cd ~
curl http://gsdview.appspot.com/dart-archive/channels/stable/release/1.17.1/sdk/dartsdk-linux-x64-release.zip && unzip dartsdk-linux-x64-release.zip && rm dartsdk-linux-x64-release.zip
```

## Добавление путей в PATH
Для этого можно воспользоваться **.bashrc**:

```bash
cd ~
echo '
export PATH=${PATH}:"~/dart-sdk/bin"
export PATH=${PATH}:"~/dartium"' >> .bashrc
source .bashrc
```

## Пакет Test теперь можно добавить в кэш:
```bash
pub cache add test
```

Клиентские тесты запускаются с помощью dartium и chrome благодаря xvfb:
```bash
xvfb-run pub run -c test -p dartium
```