import 'dart:io';

import 'package:flutter/cupertino.dart';

class PlaceLocation {
  final double? latitudine;
  final double? longitudine;
  final String? address;

  const PlaceLocation({
    @required this.latitudine,
    @required this.longitudine,
    this.address,
  });
}

class Place {
  final String? id;
  final String? title;
  final PlaceLocation? location;
  final File? image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
