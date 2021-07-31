import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:maps_location/helpers/db_helper.dart';
import 'package:maps_location/helpers/location_helper.dart';
import 'package:maps_location/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAdress(
        pickedLocation.latitudine as double,
        pickedLocation.longitudine as double);
    final updatedLocation = PlaceLocation(
      latitudine: pickedLocation.latitudine,
      longitudine: pickedLocation.longitudine,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id as String,
      'title': newPlace.title as String,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitudine as double,
      'loc_lng': newPlace.location!.longitudine as double,
      'address': newPlace.location!.address as String,
    });
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitudine: item['loc_lat'],
                longitudine: item['loc_lat'],
                address: item['address']),
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
