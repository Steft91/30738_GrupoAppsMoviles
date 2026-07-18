/* 3.Aqui se define que operacion existe: CRUD */

import '../entities/contacto.dart';

abstract class ContactoRepository {
  /* métodos CRUD */
  Future<void> agregarContacto(Contacto contacto);
  Future<void> eliminarContacto(int id);
  Future<void> actualizarContacto(Contacto contacto);
  Future<List<Contacto>> obtenerContacto();
  Future<Contacto?> obtenerContactoPorId(int id);
}
