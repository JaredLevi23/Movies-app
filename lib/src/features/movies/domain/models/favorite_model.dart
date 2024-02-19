

import 'dart:convert';

class FavoriteModel {

    final String uid;
    final String idMovie;
    final int sync;

    FavoriteModel({
      required this.uid,
      required this.idMovie,
      required this.sync
    });

    factory FavoriteModel.fromRawJson(String str) => FavoriteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavoriteModel.fromJson(Map<String, dynamic> json){
      return FavoriteModel(
        uid: json["uid"],
        idMovie: '${json["idMovie"]}',
        sync: json["sync"] ?? 0
      );
    }

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "idMovie": idMovie
    };
}
