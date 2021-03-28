import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';
import 'package:peliculas/src/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MultiProvider(providers: [
    
      ChangeNotifierProvider(create: (_) => new Favoritas())
    ], child: MyApp()));
class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final favoritas= Provider.of<Favoritas>(context, listen: false);
      favoritas.cargarScans();
      // for (var item in favoritas.favorites) {

      //   print(item);
        
      // }
      // favoritas.nuevoScan(
      //   1
      // );
      //     favoritas.nuevoScan(
      //   2
      // );
      //     favoritas.nuevoScan(
      //   3
      // );
      //     favoritas.nuevoScan(
      //   4
      // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePage(),
        'detalle' : ( BuildContext context ) => PeliculaDetalle(),

      },
    );
  }
}