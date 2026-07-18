/* llamar a los repositorios agrega contactos */
import 'dart:ui';
import '../../domain/entities/contacto.dart';
import '../../domain/repositories/contacto_repository.dart';

class ContactoUseCase {
  final ContactoRepository repository;

  ContactoUseCase(this.repository);

  Future<List<Contacto>> listar() {
    return repository.obtenerContacto();
  }

  Future<void> agregar(Contacto contacto) {
    return repository.agregarContacto(contacto);
  }

  Future<void> actualizar(Contacto contacto) {
    return repository.actualizarContacto(contacto);
  }

  Future<void> eliminar(int id) {
    return repository.eliminarContacto(id);
  }

  Future<Contacto?> obtenerPorId(int id) {
    return repository.obtenerContactoPorId(id);
  }
}
