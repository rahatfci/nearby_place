import 'dart:convert';

Places placesFromJson(String str) => Places.fromJson(json.decode(str));

String placesToJson(Places data) => json.encode(data.toJson());

class Places {
  List<Place>? places;

  Places({
    this.places,
  });

  factory Places.fromJson(Map<String, dynamic> json) => Places(
        places: json["places"] == ""
            ? []
            : List<Place>.from(json["places"]!.map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "places": places == null
            ? []
            : List<dynamic>.from(places!.map((x) => x.toJson())),
      };
}

class Place {
  String? name;
  double? lat;
  double? lng;

  Place({
    this.name,
    this.lat,
    this.lng,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        lat: double.tryParse(json["lat"]),
        lng: double.tryParse(json["lng"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat.toString(),
        "lng": lng.toString(),
      };
}
