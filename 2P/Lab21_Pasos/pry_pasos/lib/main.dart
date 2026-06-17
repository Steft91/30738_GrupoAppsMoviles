import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/historial_controller.dart';
import 'controller/pasos_controller.dart';
import 'service/almacenamiento_service.dart';
import 'service/sensor_service.dart';
import 'theme/tema_general.dart';
import 'view/historial_view.dart';
import 'view/home_view.dart';
import 'view/perfil_view.dart';
import 'view/splash_screen.dart';
import 'viewmodel/historial_viewmodel.dart';
import 'viewmodel/pasos_viewmodel.dart';
import 'viewmodel/perfil_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sensorService = SensorService();
    final almacenamientoService = AlmacenamientoService();

    final pasosController = PasosController(sensorService);
    final historialController = HistorialController(pasosController);

    return MultiProvider(
      providers: [
            ChangeNotifierProvider(
          create: (_) => PasosViewModel(
            pasosController: pasosController,
            historialController: historialController,
            almacenamientoService: almacenamientoService,
          ),
        ),
        
        ChangeNotifierProvider(
          create: (_) => HistorialViewModel(
            historialController: historialController,
            almacenamientoService: almacenamientoService,
          ),
        ),
                ChangeNotifierProvider(
          create: (_) => PerfilViewModel(
            almacenamientoService: almacenamientoService,
          ),
        ),
      ],
      child: _AppWithListeners(
        child: MaterialApp(
          title: 'Contador de Pasos',
          theme: TemaGeneral.lightTheme,
          home: const SplashNavigator(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class _AppWithListeners extends StatefulWidget {
  final Widget child;

  const _AppWithListeners({required this.child});

  @override
  State<_AppWithListeners> createState() => _AppWithListenersState();
}

class _AppWithListenersState extends State<_AppWithListeners> {
  late PasosViewModel pasosViewModel;
  late HistorialViewModel historialViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pasosViewModel = context.read<PasosViewModel>();
    historialViewModel = context.read<HistorialViewModel>();

    pasosViewModel.addListener(_sincronizarHistorial);
  }
  void _sincronizarHistorial() {
    historialViewModel.cargarHistorial();
  }

  @override
  void dispose() {
    pasosViewModel.removeListener(_sincronizarHistorial);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
class AppHome extends StatefulWidget {
  const AppHome({super.key});
  @override
  State<AppHome> createState() => _AppHomeState();
}
class _AppHomeState extends State<AppHome> {
  int _indiceNavegacion = 0;
  static const List<Widget> _vistas = <Widget>[
    HomeView(),
    HistorialView(),
    PerfilView(),
  ];

  @override
  void initState() {
    super.initState();
    _inicializarSistema();
  }
  Future<void> _inicializarSistema() async {
    if (!mounted) return;

    try {
      final pasosViewModel = context.read<PasosViewModel>();
      await pasosViewModel.inicializar();
      if (mounted) {
        final historialViewModel = context.read<HistorialViewModel>();
        await historialViewModel.cargarHistorial();
      }
      if (mounted) {
        final perfilViewModel = context.read<PerfilViewModel>();
        await perfilViewModel.cargarPerfil();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al inicializar la aplicación'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vistas[_indiceNavegacion],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _indiceNavegacion,
        onTap: (int indice) {
          setState(() {
            _indiceNavegacion = indice;
          });
        },
      ),
    );
  }
}

class SplashNavigator extends StatefulWidget {
  const SplashNavigator({super.key});

  @override
  State<SplashNavigator> createState() => _SplashNavigatorState();
}

class _SplashNavigatorState extends State<SplashNavigator> {
  bool _showSplash = true;

  void _completarSplash() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onSplashComplete: _completarSplash);
    }
    return const AppHome();
  }
}
