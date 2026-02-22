enum Flavor {
  develop,
  production,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.develop:
        return 'My Example app [DEV]';
      case Flavor.production:
        return 'My Example app';
    }
  }

  static get baseUrl {
    return switch (appFlavor) {
      Flavor.develop => "https://dev.example.com",
      Flavor.production => "https://example.com",
    };
  }
}
