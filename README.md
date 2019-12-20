A Dart library for parsing METAR meteorological data.

THIS IS WIP AND IN AN UNFINISHED STATE.

## Usage

A simple usage example:

```dart
import 'package:metar/metar.dart';

main() {
  final metarDoc = xml.parse(metarXml);
  final metar = parseRawXml(metarDoc.firstChild);
}
```
