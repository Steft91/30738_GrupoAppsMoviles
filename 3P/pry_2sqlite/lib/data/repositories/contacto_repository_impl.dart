/* implementar el contacto repository */
/* usar sqlite */
import '../../domain/entities/contacto.dart';
import '../../domain/repositories/contacto_repository.dart';
import '../datasources/contacto_local_datasource.dart';

/* clase que implementa el repositorio */
class ContactoRepositoryImpl implements ContactoRepository {
  final ContactoLocalDatasource contactoLocalDataSource;

  ContactoRepositoryImpl({required this.contactoLocalDataSource});

  @override
  Future<void> agregarContacto(Contacto contacto) {
    return contactoLocalDataSource.insertarContacto(contacto);
  }

  @override
  Future<void> actualizarContacto(Contacto contacto) {
    return contactoLocalDataSource.actualizarContacto(contacto);
  }

  @override
  Future<void> eliminarContacto(int id) {
    return contactoLocalDataSource.eliminarContacto(id);
  }

  @override
  Future<List<Contacto>> obtenerContacto() {
    return contactoLocalDataSource.obtenerContactos();
  }

  @override
  Future<Contacto?> obtenerContactoPorId(int id) {
    return contactoLocalDataSource.obtenerContactoPorId(id);
  }
}
