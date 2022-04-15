enum Flavor {
  ABI32BIT,
  ABI64BIT,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.ABI32BIT:
        return 'Alga';
      case Flavor.ABI64BIT:
        return 'Alga';
      default:
        return 'title';
    }
  }

}
