import 'package:flutter/material.dart';

import '../../themes/index.dart';
import '../atomos/boton_icono.dart';

class TarjetaRegistro extends StatelessWidget {
  final String titulo;
  final List<String> datos;
  final IconData icono;
  final IconData? iconoAccion;
  final VoidCallback? alPresionarAccion;
  final VoidCallback? alPresionar;

  const TarjetaRegistro({
    super.key,
    required this.titulo,
    required this.datos,
    required this.icono,
    this.iconoAccion,
    this.alPresionarAccion,
    this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: TemaTarjetas.tarjetaPrincipal,
      child: InkWell(
        onTap: alPresionar,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: EsquemaColor.azulComic,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: EsquemaColor.negroTinta,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icono,
                  color: EsquemaColor.negroTinta,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: EsquemaColor.negroTinta,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...datos.map(
                      (dato) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Text(
                          dato,
                          style: const TextStyle(
                            color: EsquemaColor.grisTexto,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (iconoAccion != null)
                BotonIcono(
                  icono: iconoAccion!,
                  tooltip: 'Acción',
                  tipo: TipoBotonIcono.eliminar,
                  alPresionar: alPresionarAccion,
                ),
            ],
          ),
        ),
      ),
    );
  }
}