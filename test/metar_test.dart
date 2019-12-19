import 'package:metar/metar.dart';
import 'package:test/test.dart';

const xml = '''<?xml version="1.0" encoding="UTF-8"?>
<response xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XML-Schema-instance" version="1.2" xsi:noNamespaceSchemaLocation="http://aviationweather.gov/adds/schema/metar1_2.xsd">
  <request_index>332857</request_index>
  <data_source name="metars" />
  <request type="retrieve" />
  <errors />
  <warnings />
  <time_taken_ms>4</time_taken_ms>
  <data num_results="4">
    <METAR>
      <raw_text>KPAO 191847Z 13004KT 10SM FEW020 14/10 A3024</raw_text>
      <station_id>KPAO</station_id>
      <observation_time>2019-12-19T18:47:00Z</observation_time>
      <latitude>37.47</latitude>
      <longitude>-122.12</longitude>
      <temp_c>14.0</temp_c>
      <dewpoint_c>10.0</dewpoint_c>
      <wind_dir_degrees>130</wind_dir_degrees>
      <wind_speed_kt>4</wind_speed_kt>
      <visibility_statute_mi>10.0</visibility_statute_mi>
      <altim_in_hg>30.239174</altim_in_hg>
      <sky_condition sky_cover="FEW" cloud_base_ft_agl="2000" />
      <flight_category>VFR</flight_category>
      <metar_type>METAR</metar_type>
      <elevation_m>2.0</elevation_m>
    </METAR>
    <METAR>
      <raw_text>KPAO 191747Z 15007KT 10SM FEW020 13/10 A3024</raw_text>
      <station_id>KPAO</station_id>
      <observation_time>2019-12-19T17:47:00Z</observation_time>
      <latitude>37.47</latitude>
      <longitude>-122.12</longitude>
      <temp_c>13.0</temp_c>
      <dewpoint_c>10.0</dewpoint_c>
      <wind_dir_degrees>150</wind_dir_degrees>
      <wind_speed_kt>7</wind_speed_kt>
      <visibility_statute_mi>10.0</visibility_statute_mi>
      <altim_in_hg>30.239174</altim_in_hg>
      <sky_condition sky_cover="FEW" cloud_base_ft_agl="2000" />
      <flight_category>VFR</flight_category>
      <metar_type>METAR</metar_type>
      <elevation_m>2.0</elevation_m>
    </METAR>
    <METAR>
      <raw_text>KPAO 191647Z 12008KT 10SM SCT034 12/10 A3023</raw_text>
      <station_id>KPAO</station_id>
      <observation_time>2019-12-19T16:47:00Z</observation_time>
      <latitude>37.47</latitude>
      <longitude>-122.12</longitude>
      <temp_c>12.0</temp_c>
      <dewpoint_c>10.0</dewpoint_c>
      <wind_dir_degrees>120</wind_dir_degrees>
      <wind_speed_kt>8</wind_speed_kt>
      <visibility_statute_mi>10.0</visibility_statute_mi>
      <altim_in_hg>30.230314</altim_in_hg>
      <sky_condition sky_cover="SCT" cloud_base_ft_agl="3400" />
      <flight_category>VFR</flight_category>
      <metar_type>METAR</metar_type>
      <elevation_m>2.0</elevation_m>
    </METAR>
    <METAR>
      <raw_text>KPAO 191547Z 00000KT 10SM FEW018 BKN028 11/10 A3022</raw_text>
      <station_id>KPAO</station_id>
      <observation_time>2019-12-19T15:47:00Z</observation_time>
      <latitude>37.47</latitude>
      <longitude>-122.12</longitude>
      <temp_c>11.0</temp_c>
      <dewpoint_c>10.0</dewpoint_c>
      <wind_dir_degrees>0</wind_dir_degrees>
      <wind_speed_kt>0</wind_speed_kt>
      <visibility_statute_mi>10.0</visibility_statute_mi>
      <altim_in_hg>30.221457</altim_in_hg>
      <sky_condition sky_cover="FEW" cloud_base_ft_agl="1800" />
      <sky_condition sky_cover="BKN" cloud_base_ft_agl="2800" />
      <flight_category>MVFR</flight_category>
      <metar_type>METAR</metar_type>
      <elevation_m>2.0</elevation_m>
    </METAR>
  </data>
</response>
''';


void main() {
  group('METAR tests', () {

    setUp(() {});

    test('Parses METAR XML', () {
      Metar.fromResponse(xml);
      expect(true, isTrue);
    });
  });
}
