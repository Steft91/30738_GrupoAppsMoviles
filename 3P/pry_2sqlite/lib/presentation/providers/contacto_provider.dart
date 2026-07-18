/* Provider StateNotifier StateNotifierProvider */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sqflite/sqflite.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../application/usecases/contacto_usecases.dart';
import '../../data/datasources/contacto_local_datasource.dart';
import '../../data/repositories/contacto_repository_impl.dart';
import '../../domain/entities/contacto.dart';
import '../../domain/repositories/contacto_repository.dart';

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError('La base de datos se inicia');
});

final contactoLocalDatasourceProvider = Provider<ContactoLocalDatasource>((
  ref,
) {
  final database = ref.watch(databaseProvider);
  return ContactoLocalDatasource(database);
});

final contactoRepositoryProvider = Provider<ContactoRepository>((ref) {
  final dataSource = ref.watch(contactoLocalDatasourceProvider);
  return ContactoRepositoryImpl(contactoLocalDataSource: dataSource);
});

final contactoUseCaseProvider = Provider<ContactoUseCase>((ref) {
  final repository = ref.watch(contactoRepositoryProvider);
  return ContactoUseCase(repository);
});

class ContactoNotifier extends StateNotifier<List<Contacto>> {
  final ContactoUseCase useCase;
  ContactoNotifier(this.useCase) : super([]) {
    cargarContactos();
  }

  Future<void> cargarContactos() async {
    state = await useCase.listar();
  }

  Future<void> agregarContactos(
    String nombre,
    String telefono,
    String correo,
  ) async {
    final contacto = Contacto(
      nombre: nombre,
      telefono: telefono,
      correo: correo,
      id: null,
    );
    await useCase.agregar(contacto);
    await cargarContactos();
  }

  Future<void> actualizarContactos(
    int id,
    String nombre,
    String telefono,
    String correo,
  ) async {
    final contacto = Contacto(
      id: id,
      nombre: nombre,
      telefono: telefono,
      correo: correo,
    );
    await useCase.actualizar(contacto);
    await cargarContactos();
  }

  Future<void> eliminarContactos(int id) async {
    await useCase.eliminar(id);
    await cargarContactos();
  }
}

final contactoNotifierProvider =
    StateNotifierProvider<ContactoNotifier, List<Contacto>>((ref) {
      final useCase = ref.watch(contactoUseCaseProvider);
      return ContactoNotifier(useCase);
    });
