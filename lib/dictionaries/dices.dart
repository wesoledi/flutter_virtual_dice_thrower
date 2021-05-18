class Dice {
  final String name;
  final String route;

  const Dice({
    this.name, 
    this.route
  }): super();
}

List<Dice> dices = [
  Dice(name: 'k3', route: '/dices/3'),
  Dice(name: 'k6', route: '/dices/6'),
  Dice(name: 'k8', route: '/dices/8'),
  Dice(name: 'k10', route: '/dices/10'),
  Dice(name: 'k20', route: '/dices/20'),
  Dice(name: 'k100', route: '/dices/100'),
];