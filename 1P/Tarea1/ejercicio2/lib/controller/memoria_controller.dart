import '../model/memoria_model.dart';

class MemoriaController{
  MemoriaModel? procesar(String inputGigas){
    try{
      final gigas= double.parse(inputGigas.replaceAll(',', '.'));
      if (gigas < 0){
        return null;
      }
      return MemoriaModel.calcular(gigas);
    }catch(e){
      return null;
    }
  }
}


