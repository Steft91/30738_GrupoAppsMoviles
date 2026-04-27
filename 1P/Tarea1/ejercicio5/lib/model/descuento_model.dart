// En un supermercado se hace una promocion, mediante la cual el cliente obtiene un
// descuento dependiendo de un numero due se escoge al azar. Si el numero escogido es
// menor gue 74 el descuento es del 15% sobre el total de la compra, si es mayor o igual a
// 74 el descuento es del 20%. Obtener cuanto dinero se le descuenta.

class DescuentoModel {
  final double totalCompra;
  final int numeroEscogido;

  DescuentoModel({required this.totalCompra, required this.numeroEscogido});

  double calcularDescuento() {
    return totalCompra * porcentaje / 100;
  }

  int get porcentaje => numeroEscogido < 74 ? 15 : 20;
}
