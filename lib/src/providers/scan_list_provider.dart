import 'package:flutter/material.dart';
import 'package:peliculas/src/models/fav_model.dart';

import 'db_provider.dart';

class Favoritas extends ChangeNotifier {
  List<Favorite> favorites = [];
 

  Future<int> nuevoScan(int id) async {
    final r= await DBProvider.db.nuevoScanRaw(id);
    // Asignar el ID de la base de datos al modelo
 this.favorites.add(new Favorite(id: r));

    
      notifyListeners();
       return r;
    }

   
  

  cargarScans() async {
    final List<Favorite> fav = await DBProvider.db.getTodosLosScans();
    this.favorites = [...fav];
    notifyListeners();
  }

  // cargarScanPorTipo(String tipo) async {
  //   final scans = await DBProvider.db.getScansPorTipo(tipo);
  //   this.scans = [...scans];
  //   this.tipoSeleccionado = tipo;
  //   notifyListeners();
  // }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.favorites = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
