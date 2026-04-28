class MemoriaModel{
  final double megabytes;
  final double kilobytes;
  final double bytes;

  MemoriaModel({ required this.megabytes,required this.kilobytes,required this.bytes});

  static MemoriaModel calcular(double gigas){
    final megabytes = gigas * 1024.0;
    final kilobytes = megabytes * 1024.0;
    final bytes = kilobytes * 1024.0;

    return MemoriaModel(megabytes: megabytes, kilobytes: kilobytes, bytes: bytes);
  }

}