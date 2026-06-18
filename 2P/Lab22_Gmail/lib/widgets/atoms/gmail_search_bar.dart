import 'package:flutter/material.dart';

import '../../theme/gmail_colors.dart';

/// Barra de búsqueda estilo Gmail.
/// Widget atómico reutilizable con campo de texto y acciones.
class GmailSearchBar extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String? fotoUsuario;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onMenuTap;

  const GmailSearchBar({
    super.key,
    this.hint = 'Buscar en el correo',
    required this.onChanged,
    this.onClear,
    this.fotoUsuario,
    this.onAvatarTap,
    this.onMenuTap,
  });

  @override
  State<GmailSearchBar> createState() => _GmailSearchBarState();
}

class _GmailSearchBarState extends State<GmailSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _tieneFoco = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: _tieneFoco
            ? GmailColors.superficieBlanca
            : GmailColors.fondoBusqueda,
        borderRadius: BorderRadius.circular(28),
        boxShadow: _tieneFoco
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Icono de menú / búsqueda
          IconButton(
            icon: Icon(
              _tieneFoco ? Icons.arrow_back : Icons.menu,
              color: GmailColors.textoSecundario,
              size: 22,
            ),
            onPressed: _tieneFoco
                ? () {
                    _controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).unfocus();
                  }
                : widget.onMenuTap,
          ),

          // Campo de texto
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() => _tieneFoco = hasFocus);
              },
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                style: const TextStyle(
                  fontSize: 16,
                  color: GmailColors.textoOscuro,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    color: GmailColors.textoSecundario,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  filled: true,
                ),
              ),
            ),
          ),

          // Botón limpiar / Avatar
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.close,
                color: GmailColors.textoSecundario,
                size: 22,
              ),
              onPressed: () {
                _controller.clear();
                widget.onChanged('');
                widget.onClear?.call();
              },
            )
          else
            GestureDetector(
              onTap: widget.onAvatarTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.fotoUsuario != null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(widget.fotoUsuario!),
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundColor: GmailColors.azulGoogle,
                        child: const Icon(
                          Icons.person,
                          size: 18,
                          color: GmailColors.textoBlanco,
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
