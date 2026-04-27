import 'package:ejercicio5/model/descuento_model.dart';
import 'dart:math';

class DescuentoController {
  final Random random = Random();
  String calcular(String totalCompraStr) {
    if (totalCompraStr.trim().isEmpty) {
      return 'Ingrese un total de compra válido.';
    }
    final total = double.tryParse(totalCompraStr);
    if (total == null || total <= 0) {
      return 'Ingrese un total que no sea nulo o menor a 0.';
    }
    final numeroEscogido = random.nextInt(101);

    final hayDescuento = DescuentoModel(
      totalCompra: total,
      numeroEscogido: numeroEscogido,
    );
    final descuento = hayDescuento.calcularDescuento();

    return "Número aleatorio: $numeroEscogido → Descuento del ${hayDescuento.porcentaje}%\n"
        "Descuento: \$${descuento.toStringAsFixed(2)}\n"
        "Total a pagar: \$${(total - descuento).toStringAsFixed(2)}";
  }
}
