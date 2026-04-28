import '../model/conversion_model.dart';

class ConversionController {

  // En lugar de devolver un String, devolvemos el Modelo o null si hay error.
  ConversionModel? procesar(String inputMetros) {
    try {
      // Reemplazamos comas por puntos por si el usuario escribe "1,5" en vez de "1.5"
      final metros = double.parse(inputMetros.replaceAll(',', '.'));
      return ConversionModel.calcular(metros);
    } catch (e) {
      // Si ocurre un error retornamos null
      return null;
    }
  }
}