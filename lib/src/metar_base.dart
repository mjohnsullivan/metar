import 'package:xml/xml.dart' as xml;

const URL = 'https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=KPAO&hoursBeforeNow=4';


/// Parses a raw METAR
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
Metar parseRawXml(xml.XmlElement metarDoc) {
  assert(metarDoc.firstChild.nodeType == xml.XmlNodeType.TEXT && metarDoc.name.toString() == 'METAR');
  final raw = metarDoc.findElements('raw_text').first.text;
  final stationId = metarDoc.findElements('station_id').first.text;
  return Metar(raw: raw, stationId: stationId);
}


/// Checks if you are awesome. Spoiler: you are.
class Metar {
  Metar({this.raw, this.stationId}): assert(raw != null), assert(stationId != null);
  final String raw;
  final String stationId;

  /*
  Metar.fromXML();
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
