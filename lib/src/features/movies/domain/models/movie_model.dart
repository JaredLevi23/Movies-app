
import 'dart:convert';

class MovieModel {
    final bool? adult;
    final String? backdropPath;
    final List<int>? genreIds;
    final int? id;
    final String? originalLanguage;
    final String? originalTitle;
    final String? overview;
    final double? popularity;
    final String? posterPath;
    final DateTime? releaseDate;
    final String? title;
    final bool? video;
    final double? voteAverage;
    final int? voteCount;

    MovieModel({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory MovieModel.fromRawJson(String str) => MovieModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: int.tryParse( '${json["id"]}' ),
        originalLanguage:json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: double.tryParse('${json["popularity"]}') ?? 0,
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: double.tryParse('${json["vote_average"]}') ?? 0,
        voteCount: int.tryParse( '${json["vote_count"]}' ),
    );

    factory MovieModel.fromMap(Map<String, dynamic> data) => MovieModel(
        adult: bool.tryParse( data["adult"] ),
        backdropPath: data["backdrop_path"],
        genreIds: data["genre_ids"].toString().split(',').map((e) => int.parse( e ) ).toList(),
        id: int.tryParse(data["id"]),
        originalLanguage:data["original_language"],
        originalTitle: data["original_title"],
        overview: data["overview"],
        popularity: double.tryParse(data["popularity"]),
        posterPath: data["poster_path"],
        releaseDate: DateTime.tryParse(data["release_date"]),
        title: data["title"],
        video: bool.tryParse(data["video"]),
        voteAverage: double.tryParse(data["vote_average"]),
        voteCount: int.tryParse(data["vote_count"]),
    );

    Map<String, dynamic> toJson({ String? category, String? page }) => {
        "adult": adult.toString(),
        "backdrop_path": backdropPath.toString(),
        "genre_ids": genreIds != null && genreIds!.isNotEmpty ? genreIds!.map((e) => e.toString()).join(',') : null,
        "id": id.toString(),
        "original_language": originalLanguage.toString(),
        "original_title": originalTitle.toString(),
        "overview": overview.toString(),
        "popularity": popularity.toString(),
        "poster_path": posterPath.toString(),
        "release_date": "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "title": title.toString(),
        "video": video.toString(),
        "vote_average": voteAverage.toString(),
        "vote_count": voteCount.toString(),
        "category": category,
        "page": page
    };
}

class MovieDetailModel {
    final bool adult;
    final String backdropPath;
    final dynamic belongsToCollection;
    final int budget;
    final List<Genre> genres;
    final String homepage;
    final int id;
    final String imdbId;
    final String originalLanguage;
    final String originalTitle;
    final String overview;
    final double popularity;
    final String posterPath;
    final List<ProductionCompany> productionCompanies;
    final List<ProductionCountry> productionCountries;
    final DateTime releaseDate;
    final int revenue;
    final int runtime;
    final List<SpokenLanguage> spokenLanguages;
    final String status;
    final String tagline;
    final String title;
    final bool video;
    final double voteAverage;
    final int voteCount;

    MovieDetailModel({
        required this.adult,
        required this.backdropPath,
        required this.belongsToCollection,
        required this.budget,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.imdbId,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.releaseDate,
        required this.revenue,
        required this.runtime,
        required this.spokenLanguages,
        required this.status,
        required this.tagline,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory MovieDetailModel.fromRawJson(String str) => MovieDetailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: double.tryParse(json["popularity"]) ?? 0,
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: double.tryParse(json["vote_average"]) ?? 0,
        voteCount: json["vote_count"],
    );

    MovieModel toMovieModel()=> MovieModel(
      adult: adult, 
      backdropPath: backdropPath, 
      genreIds: genres.isNotEmpty ? genres.map((e) => e.id ).toList() : [], 
      id: id, 
      originalLanguage: originalLanguage, 
      originalTitle: originalTitle, 
      overview: overview, 
      popularity: popularity, 
      posterPath: posterPath, 
      releaseDate: releaseDate, 
      title: title, 
      video: video, 
      voteAverage: voteAverage, 
      voteCount: voteCount
    );

    Map<String, dynamic> toJson({ String? category, String? page }) => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())).toString(),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "category": category,
        "page": page
    };
}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ProductionCompany {
    final int id;
    final String? logoPath;
    final String name;
    final String originCountry;

    ProductionCompany({
        required this.id,
        required this.logoPath,
        required this.name,
        required this.originCountry,
    });

    factory ProductionCompany.fromRawJson(String str) => ProductionCompany.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountry {
    final String iso31661;
    final String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    factory ProductionCountry.fromRawJson(String str) => ProductionCountry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage {
    final String englishName;
    final String iso6391;
    final String name;

    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    factory SpokenLanguage.fromRawJson(String str) => SpokenLanguage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
