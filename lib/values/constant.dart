import 'package:latlong2/latlong.dart';

const String apiKey = "QILGlvvYIhzPILGUjPMcPFwoMgTs0PKn";

final latLngDefault = LatLng(-5.1518774, 119.4469441);

final point1 = [
  {"latitude": -5.20484, "longitude": 119.49682},
  {"latitude": -5.20475, "longitude": 119.49652},
  {"latitude": -5.20430, "longitude": 119.49534},
  {"latitude": -5.20359, "longitude": 119.49557},
  {"latitude": -5.20352, "longitude": 119.49561},
  {"latitude": -5.20338, "longitude": 119.49575},
  {"latitude": -5.20326, "longitude": 119.49586},
  {"latitude": -5.20313, "longitude": 119.49591},
  {"latitude": -5.20304, "longitude": 119.49592},
  {"latitude": -5.20303, "longitude": 119.49592},
  {"latitude": -5.20237, "longitude": 119.49597},
  {"latitude": -5.20215, "longitude": 119.49431},
  {"latitude": -5.20204, "longitude": 119.49332},
  {"latitude": -5.20200, "longitude": 119.49299},
  {"latitude": -5.20187, "longitude": 119.49192},
  {"latitude": -5.20301, "longitude": 119.49194},
  {"latitude": -5.20351, "longitude": 119.49194},
  {"latitude": -5.20408, "longitude": 119.49193},
  {"latitude": -5.20424, "longitude": 119.49192},
  {"latitude": -5.20447, "longitude": 119.49190},
  {"latitude": -5.20524, "longitude": 119.49178},
  {"latitude": -5.20536, "longitude": 119.49174},
  {"latitude": -5.20564, "longitude": 119.49158},
  {"latitude": -5.20660, "longitude": 119.49096},
  {"latitude": -5.20677, "longitude": 119.49083},
  {"latitude": -5.20680, "longitude": 119.49080},
  {"latitude": -5.20685, "longitude": 119.49076},
  {"latitude": -5.20691, "longitude": 119.49068},
  {"latitude": -5.20713, "longitude": 119.49015},
  {"latitude": -5.20726, "longitude": 119.48988},
  {"latitude": -5.20752, "longitude": 119.48947},
  {"latitude": -5.20755, "longitude": 119.48942},
  {"latitude": -5.20770, "longitude": 119.48917},
  {"latitude": -5.20752, "longitude": 119.48900},
  {"latitude": -5.20735, "longitude": 119.48884},
  {"latitude": -5.20721, "longitude": 119.48872},
  {"latitude": -5.20719, "longitude": 119.48870},
  {"latitude": -5.20714, "longitude": 119.48869},
  {"latitude": -5.20699, "longitude": 119.48878},
  {"latitude": -5.20624, "longitude": 119.48918},
  {"latitude": -5.20631, "longitude": 119.48930},
  {"latitude": -5.20637, "longitude": 119.48939},
  {"latitude": -5.20691, "longitude": 119.48909}
];

final point2 = [
  {"latitude": -5.20484, "longitude": 119.49682},
  {"latitude": -5.20475, "longitude": 119.49652},
  {"latitude": -5.20430, "longitude": 119.49534},
  {"latitude": -5.20359, "longitude": 119.49557},
  {"latitude": -5.20352, "longitude": 119.49561},
  {"latitude": -5.20338, "longitude": 119.49575},
  {"latitude": -5.20326, "longitude": 119.49586},
  {"latitude": -5.20313, "longitude": 119.49591},
  {"latitude": -5.20304, "longitude": 119.49592},
  {"latitude": -5.20303, "longitude": 119.49592},
  {"latitude": -5.20237, "longitude": 119.49597},
  {"latitude": -5.20215, "longitude": 119.49431},
  {"latitude": -5.20204, "longitude": 119.49332},
  {"latitude": -5.20200, "longitude": 119.49299},
  {"latitude": -5.20187, "longitude": 119.49192},
  {"latitude": -5.20180, "longitude": 119.49130},
  {"latitude": -5.20175, "longitude": 119.49084},
  {"latitude": -5.20161, "longitude": 119.49045},
  {"latitude": -5.20159, "longitude": 119.49041},
  {"latitude": -5.20130, "longitude": 119.48997},
  {"latitude": -5.20081, "longitude": 119.48928},
  {"latitude": -5.20061, "longitude": 119.48892},
  {"latitude": -5.20056, "longitude": 119.48877},
  {"latitude": -5.20073, "longitude": 119.48864},
  {"latitude": -5.20092, "longitude": 119.48844},
  {"latitude": -5.20114, "longitude": 119.48816},
  {"latitude": -5.20150, "longitude": 119.48745},
  {"latitude": -5.20158, "longitude": 119.48730},
  {"latitude": -5.20160, "longitude": 119.48727},
  {"latitude": -5.20173, "longitude": 119.48712},
  {"latitude": -5.20184, "longitude": 119.48700},
  {"latitude": -5.20211, "longitude": 119.48676},
  {"latitude": -5.20225, "longitude": 119.48668},
  {"latitude": -5.20239, "longitude": 119.48657},
  {"latitude": -5.20255, "longitude": 119.48648},
  {"latitude": -5.20275, "longitude": 119.48635},
  {"latitude": -5.20293, "longitude": 119.48621},
  {"latitude": -5.20310, "longitude": 119.48607},
  {"latitude": -5.20319, "longitude": 119.48596},
  {"latitude": -5.20328, "longitude": 119.48580},
  {"latitude": -5.20332, "longitude": 119.48569},
  {"latitude": -5.20359, "longitude": 119.48596},
  {"latitude": -5.20361, "longitude": 119.48598},
  {"latitude": -5.20364, "longitude": 119.48600},
  {"latitude": -5.20369, "longitude": 119.48600},
  {"latitude": -5.20372, "longitude": 119.48600},
  {"latitude": -5.20382, "longitude": 119.48603},
  {"latitude": -5.20407, "longitude": 119.48634},
  {"latitude": -5.20423, "longitude": 119.48666},
  {"latitude": -5.20456, "longitude": 119.48730},
  {"latitude": -5.20486, "longitude": 119.48787},
  {"latitude": -5.20498, "longitude": 119.48807},
  {"latitude": -5.20502, "longitude": 119.48809},
  {"latitude": -5.20507, "longitude": 119.48810},
  {"latitude": -5.20527, "longitude": 119.48799},
  {"latitude": -5.20549, "longitude": 119.48788},
  {"latitude": -5.20562, "longitude": 119.48811},
  {"latitude": -5.20574, "longitude": 119.48832},
  {"latitude": -5.20583, "longitude": 119.48849},
  {"latitude": -5.20586, "longitude": 119.48853},
  {"latitude": -5.20599, "longitude": 119.48874},
  {"latitude": -5.20611, "longitude": 119.48896},
  {"latitude": -5.20618, "longitude": 119.48909},
  {"latitude": -5.20624, "longitude": 119.48918},
  {"latitude": -5.20631, "longitude": 119.48930},
  {"latitude": -5.20637, "longitude": 119.48939},
  {"latitude": -5.20691, "longitude": 119.48909}
];

final point3 = [];

final point4 = [];

final checkRoute = [
  {'latitude': -5.20484, 'longitude': 119.49682},
  {'latitude': -5.20475, 'longitude': 119.49652},
  {'latitude': -5.2043, 'longitude': 119.49534},
  {'latitude': -5.20359, 'longitude': 119.49557},
  {'latitude': -5.20352, 'longitude': 119.49561},
  {'latitude': -5.20338, 'longitude': 119.49575},
  {'latitude': -5.20326, 'longitude': 119.49586},
  {'latitude': -5.20313, 'longitude': 119.49591},
  {'latitude': -5.20304, 'longitude': 119.49592},
  {'latitude': -5.20303, 'longitude': 119.49592},
  {'latitude': -5.20237, 'longitude': 119.49597},
  {'latitude': -5.20215, 'longitude': 119.49431},
  {'latitude': -5.20204, 'longitude': 119.49332},
  {'latitude': -5.202, 'longitude': 119.49299},
  {'latitude': -5.20187, 'longitude': 119.49192},
  {'latitude': -5.20301, 'longitude': 119.49194},
  {'latitude': -5.20351, 'longitude': 119.49194},
  {'latitude': -5.20408, 'longitude': 119.49193},
  {'latitude': -5.20424, 'longitude': 119.49192},
  {'latitude': -5.20447, 'longitude': 119.4919},
  {'latitude': -5.20524, 'longitude': 119.49178},
  {'latitude': -5.20536, 'longitude': 119.49174},
  {'latitude': -5.20564, 'longitude': 119.49158},
  {'latitude': -5.2066, 'longitude': 119.49096},
  {'latitude': -5.20677, 'longitude': 119.49083},
  {'latitude': -5.2068, 'longitude': 119.4908},
  {'latitude': -5.20685, 'longitude': 119.49076},
  {'latitude': -5.20691, 'longitude': 119.49068},
  {'latitude': -5.20713, 'longitude': 119.49015},
  {'latitude': -5.20726, 'longitude': 119.48988},
  {'latitude': -5.20752, 'longitude': 119.48947},
  {'latitude': -5.20755, 'longitude': 119.48942},
  {'latitude': -5.2077, 'longitude': 119.48917},
  {'latitude': -5.20752, 'longitude': 119.489},
  {'latitude': -5.20735, 'longitude': 119.48884},
  {'latitude': -5.20721, 'longitude': 119.48872},
  {'latitude': -5.20719, 'longitude': 119.4887},
  {'latitude': -5.20714, 'longitude': 119.48869},
  {'latitude': -5.20699, 'longitude': 119.48878},
  {'latitude': -5.20624, 'longitude': 119.48918},
  {'latitude': -5.20631, 'longitude': 119.4893},
  {'latitude': -5.20637, 'longitude': 119.48939},
  {'latitude': -5.20691, 'longitude': 119.48909}
];
