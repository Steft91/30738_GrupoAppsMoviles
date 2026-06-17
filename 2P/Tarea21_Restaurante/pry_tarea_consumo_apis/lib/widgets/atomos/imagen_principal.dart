import 'package:flutter/material.dart';

class ImagenPrincipal extends StatelessWidget {
  final String? url;
  final double height;
  final IconData icono;

  const ImagenPrincipal({
    super.key,
    this.url,
    this.height = 170,
    this.icono = Icons.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: height,
        width: double.infinity,
        color: Colors.deepOrange.shade50,
        child: url == null || url!.isEmpty
            ? Icon(icono, size: 64, color: Colors.deepOrange)
            : Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Icon(icono, size: 64, color: Colors.deepOrange);
                },
              ),
      ),
    );
  }
}
