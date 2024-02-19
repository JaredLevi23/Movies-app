
const String _baseUrlTmdb = 'https://api.themoviedb.org/3';
const String _keyTmdb = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NWU1OTIzZDRkYWEwZjNkYWNlYjc2Y2I5NWNlNWQ3MCIsInN1YiI6IjVmNGZjZjcyYzU4NDBkMDAzODc3NTJmNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ygsh-AvFuUPPc7d3Ovau-9aZYbu9ioJy96QFrmwZZzE';

String getTmdbUrl(){
  return _baseUrlTmdb;
}

String getKeyTmdb(){
  return _keyTmdb;
}