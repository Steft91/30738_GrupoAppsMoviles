/* Inicia el SQLITE */
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/contacto.dart';

class ContactoLocalDatasource {
  /* instanciar */
  final Database database;
  ContactoLocalDatasource(this.database);
  /* metodos */
  /* Método obtener contactos: */
  Future<List<Contacto>> obtenerContactos() async {
    final result = await database.query('contactos', orderBy: 'id DESC');
    return result.map((map) {
      return Contacto(
        id: map['id'] as int,
        nombre: map['nombre'] as String,
        telefono: map['telefono'] as String,
        correo: map['correo'] as String,
      );
    }).toList();
  }

  /* Método para insertar contactos */
  Future<void> insertarContacto(Contacto contacto) async {
    await database.insert('contactos', {
      'nombre': contacto.nombre,
      'telefono': contacto.telefono,
      'correo': contacto.correo,
    });
  }

  /* Obtener contacto por id */
  Future<Contacto?> obtenerContactoPorId(int id) async {
    final result = await database.query(
      'contactos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    final map = result.first;
    return Contacto(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      telefono: map['telefono'] as String,
      correo: map['correo'] as String,
    );
  }

  /* Método para actualizar contactos */
  Future<void> actualizarContacto(Contacto contacto) async {
    await database.update(
      'contactos',
      {
        'nombre': contacto.nombre,
        'telefono': contacto.telefono,
        'correo': contacto.correo,
      },
      where: 'id = ?',
      whereArgs: [contacto.id],
    );
  }

  /* Método para eliminar contactos */
  Future<void> eliminarContacto(int id) async {
    await database.delete('contactos', where: 'id = ?', whereArgs: [id]);
  }
}
