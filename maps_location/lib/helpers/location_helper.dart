import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDkma_WKZZRSJMpLoDbaB0tOpmkrlaUoV4';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAdress(double lat, double lgt) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lgt&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
