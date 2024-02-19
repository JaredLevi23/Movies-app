import 'dart:convert';

class ReviewsModel {
    final int? id;
    final int? page;
    final List<ReviewModel>? results;
    final int? totalPages;
    final int? totalResults;

    ReviewsModel({
        this.id,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory ReviewsModel.fromRawJson(String str) => ReviewsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        id: json["id"],
        page: json["page"],
        results: json["results"] == null ? [] : List<ReviewModel>.from(json["results"]!.map((x) => ReviewModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };

    ReviewsModel copyWith({
      int? id,
      int? page,
      List<ReviewModel>? results,
      int? totalPages,
      int? totalResults,
    }) => ReviewsModel(
      id: id ?? this.id,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults
    );
}

class ReviewModel {
    
    final String? author;
    final AuthorDetails? authorDetails;
    final String? content;
    final DateTime? createdAt;
    final String? id;
    final DateTime? updatedAt;
    final String? url;
    final String? idMovie;
    final String? uid;

    ReviewModel({
        this.author,
        this.uid,
        this.authorDetails,
        this.content,
        this.createdAt,
        this.id,
        this.updatedAt,
        this.url,
        this.idMovie
    });

    factory ReviewModel.fromRawJson(String str) => ReviewModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        author: json["author"],
        authorDetails: json["author_details"] == null ? null : AuthorDetails.fromJson(json["author_details"]),
        content: json["content"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        url: json["url"],
        idMovie: json["idMovie"],
        uid: json["uid"]
    );

    Map<String, dynamic> toJson(){

      Map<String, dynamic> map = {
        "id": id,
        "author": author,
        "content": content,
        "url": url,
        "created_at": createdAt?.toIso8601String() ?? "",
        "uid": uid
      };

      return map;
    }

    ReviewModel copyWith({
      String? id,
      String? author,
      String? content,
      String? url,
      String? idMovie,
      DateTime? createdAt,
      String? uid
    }) => ReviewModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      idMovie: idMovie ?? this.idMovie,
      uid: uid ?? this.uid
    );
}

class AuthorDetails {
    final String? name;
    final String? username;
    final String? avatarPath;
    final int? rating;

    AuthorDetails({
        this.name,
        this.username,
        this.avatarPath,
        this.rating,
    });

    factory AuthorDetails.fromRawJson(String str) => AuthorDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: int.tryParse( '${json["rating"]}' )
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
    };
}
