import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara = new Usuario(
    online: false,
    email: 'email',
    nombre: 'nombre',
    uid: 'uid',
  );

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final token = await AuthService.getToken();
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token == null ? 'token' : token,
      },
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
