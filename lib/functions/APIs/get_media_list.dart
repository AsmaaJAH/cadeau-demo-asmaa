  List mediaList(List listOfMaps) {
// simple example
  // final listOfMaps = [
  //   {'id': 1, 'name': 'flutter', 'title': 'dart'},
  //   {'id': 35, 'name': 'flutter', 'title': 'dart'},
  //   {'id': 93, 'name': 'flutter', 'title': 'dart'},
  //   {'id': 82, 'name': 'flutter', 'title': 'dart'},
  //   {'id': 28, 'name': 'flutter', 'title': 'dart'},
  // ];

  final listOfUrlStrings = listOfMaps.map((entry) => entry['url']).toList(); // for example [1, 35, 93, 82, 28]
  return listOfUrlStrings;
  }