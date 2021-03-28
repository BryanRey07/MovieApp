// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
    Favorite({
        this.id,
    });

    int id;

    factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
