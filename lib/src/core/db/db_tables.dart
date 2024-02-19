

class DBTables {

  static const String favoritesTable = '''
    CREATE TABLE IF NOT EXISTS favorites(
        uid TEXT,
        idMovie TEXT
      )
  ''';

    static const String moviesTable = '''
    CREATE TABLE IF NOT EXISTS movies(
        adult TEXT,
        backdrop_path TEXT,
        genre_ids TEXT,
        id TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity TEXT,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        video TEXT,
        vote_average TEXT,
        vote_count TEXT,
        page TEXT,
        category TEXT
      )
  ''';

  static const String searchsTable = '''
    CREATE TABLE IF NOT EXISTS searchs(
        search TEXT
      )
  ''';

}