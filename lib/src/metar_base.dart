import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

const URL =
    'https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=KPAO&hoursBeforeNow=4';

/// Fetch METAR XML data for a specified airport
Future<String> fetchMetarResponse(String airportCode) async {
  assert(airportCode.length == 3);
  final res = await http.get(URL);
  return res.body;
}

/// Parses an aviation weather server response
/// <response xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XML-Schema-instance" version="1.2" xsi:noNamespaceSchemaLocation="http://aviationweather.gov/adds/schema/metar1_2.xsd">
///   <request_index>332857</request_index>
///   <data_source name="metars" />
///   <request type="retrieve" />
///   <errors />
///   <warnings />
///   <time_taken_ms>4</time_taken_ms>
///   <data num_results="4">
///     <METAR>...</METAR>
///   </data>
/// </response>
Iterable<Metar> parseMetarResponse(String res) {
  final xmlDoc = xml.parse(res);
  assert(xmlDoc.rootElement.name.toString() == 'response');
  final type =
      xmlDoc.rootElement.findElements('data_source').first.getAttribute('name');
  final errors = xmlDoc.rootElement.findElements('errors').first.children;
  if (errors.isNotEmpty) {
    throw Exception('Error(s) fetching data');
  }
  return xmlDoc.rootElement
      .findElements('data')
      .first
      .findElements('METAR')
      .map((metarXml) => parseMetarXml(metarXml));
}

/// Parses a METAR in XML format
///
/// <METAR>
///   <raw_text>KPAO 191847Z 13004KT 10SM FEW020 14/10 A3024</raw_text>
///   <station_id>KPAO</station_id>
///   <observation_time>2019-12-19T18:47:00Z</observation_time>
///   <latitude>37.47</latitude>
///   <longitude>-122.12</longitude>
///   <temp_c>14.0</temp_c>
///   <dewpoint_c>10.0</dewpoint_c>
///   <wind_dir_degrees>130</wind_dir_degrees>
///   <wind_speed_kt>4</wind_speed_kt>
///   <visibility_statute_mi>10.0</visibility_statute_mi>
///   <altim_in_hg>30.239174</altim_in_hg>
///   <sky_condition sky_cover="FEW" cloud_base_ft_agl="2000" />
///   <flight_category>VFR</flight_category>
///   <metar_type>METAR</metar_type>
///   <elevation_m>2.0</elevation_m>
/// </METAR>
Metar parseMetarXml(xml.XmlElement metarDoc) {
  assert(metarDoc.firstChild.nodeType == xml.XmlNodeType.TEXT &&
      metarDoc.name.toString() == 'METAR');
  final raw = metarDoc.findElements('raw_text').first.text;
  final stationId = metarDoc.findElements('station_id').first.text;
  final observationTime =
      DateTime.parse(metarDoc.findElements('observation_time').first.text);
  final latitude = double.parse(metarDoc.findElements('latitude').first.text);
  final longitude = double.parse(metarDoc.findElements('longitude').first.text);
  final temperature = double.parse(metarDoc.findElements('temp_c').first.text);
  final dewpoint = double.parse(metarDoc.findElements('dewpoint_c').first.text);
  final windDirection =
      int.parse(metarDoc.findElements('wind_dir_degrees').first.text);
  final windSpeed =
      int.parse(metarDoc.findElements('wind_speed_kt').first.text);
  final visibility =
      double.parse(metarDoc.findElements('visibility_statute_mi').first.text);
  final altimeter =
      double.parse(metarDoc.findElements('altim_in_hg').first.text);
  final skyCondition =
      SkyCondition.fromXml(metarDoc.findElements('sky_condition').first);
  final type = metarDoc.findElements('metar_type').first.text;
  final elevation =
      double.parse(metarDoc.findElements('elevation_m').first.text);
  return Metar(
    raw: raw,
    stationId: stationId,
    observationTime: observationTime,
    latitude: latitude,
    longitude: longitude,
    temperature: temperature,
    dewpoint: dewpoint,
    windDirection: windDirection,
    windSpeed: windSpeed,
    visibility: visibility,
    altimeter: altimeter,
    skyCondition: skyCondition,
    type: type,
    elevation: elevation,
  );
}

/// METAR data class
class Metar {
  Metar({
    @required this.raw,
    @required this.stationId,
    @required this.observationTime,
    @required this.latitude,
    @required this.longitude,
    @required this.temperature,
    @required this.dewpoint,
    @required this.windDirection,
    @required this.windSpeed,
    @required this.visibility,
    @required this.altimeter,
    @required this.skyCondition,
    @required this.type,
    @required this.elevation,
  });
  final String raw, stationId, type;
  final DateTime observationTime;
  final double latitude,
      longitude,
      temperature,
      dewpoint,
      visibility,
      altimeter,
      elevation;
  final int windDirection, windSpeed;
  final SkyCondition skyCondition;

  factory Metar.fromXml(xml.XmlElement element) => parseMetarXml(element);
  /*
  Metar.fromRaw();
  Metar.fromResponse(String response) {
    final doc = xml.parse(response);
    final metarDocs = doc.findAllElements('METAR');
    for (var metarDoc in metarDocs) {
      parseRawXml(metarDoc);
    }
  }
  */

}

/// Parses sky condition XML elements
///
/// <sky_condition sky_cover="FEW" cloud_base_ft_agl="2000" />
SkyCondition parseRawSkyConditionXml(xml.XmlElement skyElem) {
  assert(skyElem.nodeType == xml.XmlNodeType.ELEMENT &&
      skyElem.name.toString() == 'sky_condition');
  final cover = skyElem.getAttribute('sky_cover');
  final cloudBase = int.parse(skyElem.getAttribute('cloud_base_ft_agl'));
  return SkyCondition(cover: cover, cloudBase: cloudBase);
}

/// Sky conditions data class
class SkyCondition {
  SkyCondition({@required this.cover, @required this.cloudBase});
  final String cover;
  final int cloudBase;

  factory SkyCondition.fromXml(xml.XmlElement element) =>
      parseRawSkyConditionXml(element);
}
