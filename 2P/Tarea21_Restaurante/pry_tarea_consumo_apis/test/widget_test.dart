import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pry_tarea_consumo_apis/app.dart';
import 'package:pry_tarea_consumo_apis/viewmodels/pedido_viewmodel.dart';
import 'package:pry_tarea_consumo_apis/viewmodels/plato_viewmodel.dart';

void main() {
  testWidgets('muestra la pantalla splash inicial', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlatoViewModel()),
          ChangeNotifierProvider(create: (_) => PedidoViewModel()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('Restaurante App'), findsOneWidget);
    expect(find.text('Pedidos rápidos y fáciles'), findsOneWidget);
  });
}
