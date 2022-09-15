class Country {
  final String title;
  final int hourStatus;
  const Country({required this.title, required this.hourStatus});
}

const List<Country> countries = [
  Country(title: 'Saudi Arabia', hourStatus: -3),
  Country(title: 'London', hourStatus: -5),
  Country(title: 'US Washington', hourStatus: -10),
];
