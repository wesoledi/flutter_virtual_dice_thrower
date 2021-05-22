import 'package:virtual_dice/dictionaries/types/named_route.dart';
import 'package:virtual_dice/widgets/pages/special/params.dart';

List<NamedRoute> dndWeaponDices = [
  NamedRoute(name: 'k4+', route: '4', params: [ SpecialPageParams(mayRise: true) ]),
  NamedRoute(name: 'k6+', route: '6', params: [ SpecialPageParams(mayRise: true) ]),
  NamedRoute(name: 'k8+', route: '8', params: [ SpecialPageParams(mayRise: true) ]),
  NamedRoute(name: 'k10+', route: '10', params: [ SpecialPageParams(mayRise: true) ]),
  NamedRoute(name: 'k12+', route: '12', params: [ SpecialPageParams(mayRise: true) ]),
  NamedRoute(name: 'k20', route: '20', params: [ SpecialPageParams() ]),
  NamedRoute(name: 'k100', route: '100', params: [ SpecialPageParams() ]),
];
