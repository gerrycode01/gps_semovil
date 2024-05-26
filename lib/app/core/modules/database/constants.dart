class Const {
  static List<String> bloodtypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  static List<String> driverLicensesTypes = [
    'Licencia De Chofer',
    'Licencia Automovilista',
    'Licencia Motociclista'
  ];

  static Map<int, String> statusForm = {
    0: 'POR PAGAR',
    1: 'EN REVISION',
    2: 'ACEPTADA',
    3: 'DENEGADA',
    4: 'OCULTA'
  };

  static Map<String, double> driverLicensesPrices = {
    'Licencia De Chofer': 1078.00,
    'Licencia Automovilista': 926.00,
    'Licencia Motociclista': 774.00,
  };

  static Map<String, double> driverLicensesPricesRenew = {
    'Licencia De Chofer': 648.00,
    'Licencia Automovilista': 466.00,
    'Licencia Motociclista': 534.00,
  };

  static Map<String, double> driverLicensesPricesLostTheft = {
    'Licencia De Chofer': 540.00,
    'Licencia Automovilista': 464.00,
    'Licencia Motociclista': 388.00,
  };
}
