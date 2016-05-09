import 'package:angular2/core.dart';

import 'car/car.dart';
import 'heroes/hero.dart';
import 'heroes/hero_service.dart';
import 'heroes/hero_service_provider.dart';
import 'logger_service.dart';

@Component(
    selector: 'my-injectors',
    template: '''
      <h2>Other Injections</h2>
      <div id="car">{{car.drive()}}</div>
      <div id="hero">{{hero.name}}</div>
      <div id="rodent">{{rodent}}</div>''',
    providers: const [
      Car,
      Engine,
      Tires,
      const Provider(HeroService, useFactory: heroServiceFactory),
      Logger
    ])
class InjectorComponent {
  final Injector _injector;
  Car car;
  HeroService heroService;
  Hero hero;

  String get rodent {
    try {
      _injector.get(ROUS);
    } on NoProviderError {
      return "R.O.U.S.'s? I don't think they exist!";
    }
    throw new Exception('Aaaargh!');
  }

  InjectorComponent(this._injector) {
    car = _injector.get(Car);
    heroService = _injector.get(HeroService);
    hero = heroService.getHeroes()[0];
  }
}

/**
 * R.O.U.S. - Rodents Of Unusual Size
 * // https://www.youtube.com/watch?v=BOv5ZjAOpC8
 */
class ROUS {}
