import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
class ScanModel {
    ScanModel({
        this.id,
        this.tipo,
        @required this.valor,
    }) {

      if ( this.valor.contains('http') ) {
        this.tipo = 'http';
      } else { 
        this.tipo = 'geo';
      }

    }

    int id;
    String tipo;
    String valor;

    LatLng getLatLng() {

      final latLng = this.valor.substring(4).split(',');
      final lat = double.parse( latLng[0] );
      final lng = double.parse( latLng[1] );

      return LatLng( lat, lng );
    }
//crea una instancia
    factory ScanModel.fromJson(Map<String, dynamic> json ) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );
//retornar objeto del mismo tipo
    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
    /*
//metodo q ayude a retornar la latitud y longitud

  getLatLng() {
    
    final lalo = valor.substring(4).split(',');
    final lat = double.parse(lalo[0]);
    final lng = double.parse(lalo[1]);

    return LatLng(lat, lng);
    */
}
