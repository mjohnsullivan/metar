import 'package:xml/xml.dart' as xml;

const URL = 'https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=KPAO&hoursBeforeNow=4';





/// Checks if you are awesome. Spoiler: you are.
class Metar {
  Metar._();

  Metar.fromXML();
  Metar.fromRaw();
  Metar.fromResponse(String response) {
    final doc = xml.parse(response);
    final metarElements = doc.findAllElements('METAR');
    print(metarElements.length);
  }

}
