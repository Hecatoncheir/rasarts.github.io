<!--
title: Удобный pipline для работы 
date: 2015/08/18
id: 790ab9a6-d647-4669-9814-65715d0f23a0
category: Руководство к действию
icon: tutorial
labels:
  - Dart
  - Pipline
-->

Здесь я опишу какие библиотеки и фреймворки я предпочитаю использовать в процессе разработки (подготовки, производства). Так называемый программный конвеер. Но тут не пойдет речь о тестировании, это тема для отдельной большой статьи.

**Понадобятся следующие компоненты:**

  **Dart**
    - Grinder
    - Sass - для работы с sass в dart
    - Peanut - для удобного удобного управления сборкой в отдельную ветку git
  **Rudy**
    - Gem
    - Guard
    - CTags
    - Sass
    - Compass
    - Susy
    - Breakpoint
    - LiveReload - для работы с livereload в ruby
  **Node**
    - Csscomb
    - Svgo
  **Python**
    - LiveReload
    - ImageMagick


<br>
<br>
<br>
**Gemfile** может выглядеть следующим образом:

```language-ruby

source 'https://rubygems.org'

gem 'sass'
gem 'compass'
gem 'livereload'
gem 'guard'
gem 'guard-compass'
gem 'guard-livereload'
gem 'guard-ctags-bundler'

gem 'gem-ctags'

gem 'breakpoint'
gem 'susy'
```
<br>

##Grinder

[*Документация*](http://www.dartdocs.org/documentation/grinder/0.7.2/index.html#grinder)

*Установка:*
```language-bash
pub global activate grinder
```

- Библиотека позволяет автоматизировать рабочие процессы.

К примеру можно написать несколько удобных тасков для инициализации и установки всех зависимостей, а так же сборки приложения.

```language-dart

import 'package:grinder/grinder.dart';
import 'dart:io';

main(args) => grind(args);


@Task('Initialize stuff.')
init(GrinderContext context) {

  Process.run('pub',['get']).then((results){
      print(results.stdout);
      print('Pub is ready'); 
    });

  Process.run('bundle',[]).then((results){
      print(results.stdout);
      print('Bundle ready');
    });

  Process.run('compass', ['init']).then((ProcessResult results) {
      print('Compass Initialize');
    });

}

@Task('Make build')
@Depends(compileStyles)
  build(GrinderContext context){
  
    print('Make build');
  
    Process.run('compass', ['compile']).then((ProcessResult results) {
        print(results.stdout);
        print('Styles compiled');
      });
       
  }


@Task('Compiled styles')
compileStyles(context){

  Process.run('pub',['build']).then((results){
      print(results.stdout);
      print('Build ready');
    });

}

```

В дальнейшем можно будет использовать простые команды:
```language-bash
  # Для создания всего необходимого для compass, получения зависимостей dart пакетов и bundle для ruby.
  grind init 

  # Для сборки билда и компиляции стилей
  grind build
```


##Sass 
- это метаязык на основе CSS, предназначенный для увеличения уровня абстракции CSS кода и упрощения файлов каскадных таблиц стилей.

[*Документация*](http://sass-lang.com/documentation/file.SASS_REFERENCE.html)

*Установка:*
```language-bash
gem install sass
```
Для компиляции *.sass* или *.scss* файлов при изменении, используется команда:

```language-bash
sass --watch путь/до/файла/или/папки:путь/до/скомпилированной/директроии/или/файла
```

В dart файле *pubspec.yaml* нужно указать зависимость и указать трансформер для сборки билда:

```language-dart
dependencies: 
  sass: any

transformers:
  - sass:
      style: compact                
      compass: true
      copy-sources: false
```

Теперь при запуске *pub build* .sass и .scss файлы будут скомпилированы в **.css** и размещены в тех же директориях.

##С **Sass** часто удобно использовать следующие *gem`ы*:

**Susy** - хорошая вещь для создания разнообразных сеток.

 [*Документация*](http://susydocs.oddbird.net/en/latest/)

 *Установка:*
```language-bash
 gem install susy
```
**Breakpoint** - позволяет очень удобно расставлять медиа запросы.

 [*Документация*](http://breakpoint-sass.com/)

 *Установка:*
```language-bash
 gem install breakpoint
```

Так же есть аналогичные библиотеки *Bourbon* и *Neat*. Я работал с ними раньше, но во многом *susy* и *compass* мне понравились больше.

##О **Compass**
 [*Документация*](http://breakpoint-sass.com/)

 *Установка:*
```language-bash
 gem install compass
```


##Guard

![ScreenShot](https://raw.githubusercontent.com/Rasarts/Dart-Starter-Kit/preview/2015-03-14%2001_10_42.gif)

[YouTube](http://youtu.be/sSlGonSMSuM)
