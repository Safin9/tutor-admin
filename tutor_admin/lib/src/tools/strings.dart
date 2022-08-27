class RequiredStrings {
  final days = <String>[];
  final months = <String>[];
  final years = <String>[];
  List<String> citysList = [
    'Erbil',
    'Duhok',
    'Slemmany',
    'Karkuk',
    'Zakho',
    'Halabja'
  ];

  List<String> gender = [
    'Male',
    'Female',
  ];
  List<String> lessonType = [
    'Kurdish',
    'English',
    'Arabic',
    'Mathematics',
    'Chemistry',
    'Physics',
    'Biology',
    'Geography',
  ];
  methodForInts() {
    for (var i = 0; i < 32; i++) {
      days.add('$i');
    }
    for (var i = 1; i < 13; i++) {
      months.add('$i');
    }
    for (var i = 2022; i > 1950; i--) {
      years.add('$i');
    }
  }
}
