import 'package:experiment/models/places.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlacesModel extends ChangeNotifier {
  Places places = Places(places: []);
  late SharedPreferences preferences;
  void add(Place item) {
    try {
      places.places!.add(item);
      preferences.setString('places', placesToJson(places));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  PlacesModel(this.preferences);
  void get() {
    try {
      String existing = preferences.getString('places') ?? "";
      if (existing.isNotEmpty) {
        places = placesFromJson(existing);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  filter({required double lat, required double lng}) {
    List<Place> filterData = [];
    try {
      for (var i = 0; i < places.places!.length; i++) {
        if (Geolocator.distanceBetween(
                lat, lng, places.places![i].lat!, places.places![i].lng!) <=
            2000) {
          filterData.add(places.places![i]);
        }
      }
      return filterData;
    } catch (e) {
      print(e);
    }
  }
}
