class ConversionModel {
  final double centimetros;
  final double pulgadas;
  final double pies;
  final double yardas;

  ConversionModel({
    required this.centimetros,
    required this.pulgadas,
    required this.pies,
    required this.yardas,
  });

  static ConversionModel calcular(double metros) {
    final centimetros = metros * 100.0;
    final pulgadas = centimetros / 2.54;
    final pies = pulgadas / 12.0;
    final yardas = pies / 3.0;

    return ConversionModel(
      centimetros: centimetros,
      pulgadas: pulgadas,
      pies: pies,
      yardas: yardas,
    );
  }
}