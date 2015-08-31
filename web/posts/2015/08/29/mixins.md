<!--
title: Mixins
date: 2015/08/29
id: 694b0e0b-e30d-4970-8680-5ead3cbbfc6e
category: Примеры кода Dart
icon: dart_tutorial
labels:
  - Dart
  - Mixins
-->

Dart позволяет наследовать **примеси (mixins)**, благодаря чему код класса может быть использован во множественных иерархиях классов, как показано в следующем примере:

```language-dart
library trailer;

// Прицеп
class Trailer {
  // Доступ к информации о грузоподъемности машины
  double carrying = 0.0;

  // Прицеп может выдерживать [вес]
  void carry(double weight) {
    // Машины могут увеличивать свою грузоподьемность
    carrying += weight;
  }
}
```

Класс *Trailer* независим от класса **Car**, но способен увеличивать грузоподьемность автомобиля. Мы подмешаем *Trailer* в класс *PassengerCar* с помощью ключевого слова **mixin**:

```language-dart
library passenger_car;
import 'car.dart';
import 'trailer.dart';

// Пассажирская машина с прицепом.
class PassengerCar extends Car with Trailer {
  // Максимальное число пассажиров
  int maxPassengers = 4;

  /**
   * Создание [PassengerCar] с [цветом], [грузоподьемностью] и [максимальным числом пассажиров].
   * Мы можем использовать [Trailer] для увеличения [максимальной грузоподьемности].
   */
  PassengerCar(String color, double carrying, this.maxPassengers,
      {double extraWeight:0.0}) : super(color, carrying) {
    // Увеличение грузоподьемности с помощью класса [Trailer]
    carry(extraWeight);
  }
}
```

Мы добавили *Trailer* как миксин в *PassangerCar* и как результат *PassangerCar* теперь может перевозить больше веса. Мы не изменяли сам класс *PassangerCar*, мы только расширили его функциональность. В тоже время, прицеп может быть использован вместе с *Truck* или *Bus* классами. **Mixin** выглядит как интерфейс и определяется как класс, но имеет следующие ограничения:

-	не содержит конструктора
-	суперклассом миксина может быть только *Object*
-	не содержит *super* вызовов