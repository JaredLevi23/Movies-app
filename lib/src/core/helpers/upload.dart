
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFile{

  Future<String> uploadFile(File file) async {
    try {
      // Inicializar Firebase
      await Firebase.initializeApp();
      // Referencia al storage de Firebase
      FirebaseStorage storage = FirebaseStorage.instance;
      // Referencia al archivo en Firebase Storage
      final ref = storage.ref().child( file.path.split('/').last );
      // Subir archivo
      final data = await ref.putFile(file);
      final url = await data.ref.getDownloadURL();
      print('Archivo subido exitosamente ${ data.ref.fullPath }');
      return url;
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

}