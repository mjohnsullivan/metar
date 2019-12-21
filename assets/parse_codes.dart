import 'dart:io';
import 'dart:convert' show json;

// final regex = RegExp(r'^([\w]{3})\t"(.+)"\t(\d+)$');
final regex = RegExp(r'^([\w]{3})\t"?([^"]+)"?\t(\d+)$');

void main() {
  final airportList = [];
  File('./airport_codes.txt').readAsLinesSync().forEach((line) {
    final match = regex.firstMatch(line);
    if (match != null) {
      print('${match.group(1)} - ${match.group(2)} - ${match.group(3)}');
      final airportCode = match.group(1);
      final address = match.group(2).trim();
      final worldAreaCode = int.parse(match.group(3));
      airportList
          .add({'code': airportCode, 'address': address, 'wac': worldAreaCode});
    } else {
      print('No match: $line');
    }
  });
  File('airport_codes.json').writeAsStringSync(json.encode(airportList));
}
