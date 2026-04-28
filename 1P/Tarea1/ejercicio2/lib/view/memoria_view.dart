import 'dart:ffi';

import 'package:flutter/material.dart';
import '../controller/memoria_controller.dart';
import '../model/memoria_model.dart';


//Caja de texto - Atomo

class ATextField extends StatelessWidget{

  final TextEditingController controlador;
  final String textoAyuda;
  final IconData icono;
  final Color colorPrincipal;

  ATextField({super.key, required this.controlador, required this.textoAyuda,required this.icono, this.colorPrincipal = Colors.blueAccent
  });

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: textoAyuda,
        labelStyle: TextStyle(color: colorPrincipal),
        prefixIcon: Icon(icono, color: colorPrincipal),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFF95A1F1)),
        ) ,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: colorPrincipal, width: 2),
        ),

      ),
    );
  }
}


// boton - atomo

class ABoton extends StatelessWidget{
  final String texto;
  final VoidCallback presionar;
  final Color colorBoton;

  ABoton({super.key, required this.texto, required this.presionar, this.colorBoton = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: presionar,
        child: CircleAvatar(
            radius: 25,
            backgroundColor: colorBoton,
            child: const Icon(Icons.calculate, color: Color(0xFFFFFFFF))
        )
    );
  }

}

//Molecula - Ingreso de datos



class MIngreso extends StatelessWidget{
  final TextEditingController controlador;
  final VoidCallback calcular;
  final Color colorTema;
  final String textoHint;
  final IconData icono;

  MIngreso({
    super.key,
    required this.controlador,
    required this.calcular,
    required this.colorTema,
    this.textoHint = 'Ingresar...',
    this.icono = Icons.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ATextField(
              controlador: controlador,
              textoAyuda: textoHint,
              icono: icono,
              colorPrincipal: colorTema),
        ),
        const SizedBox(width: 10),
        ABoton(presionar: calcular, colorBoton: colorTema, texto: '',),
      ],
    );
  }
}


class MResultados extends StatelessWidget{
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  MResultados({super.key, required this.titulo, required this.valor, required this.icono, required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icono, color: color),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        trailing: Text(
          valor,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color
          ),
        ),
      ),
    );
  }

}



//Organismo

class MemoriaVista extends StatefulWidget{

  final Color colorTema;
  const MemoriaVista({super.key, required this.colorTema
  });

  @override
  State<MemoriaVista> createState() => MemoriaVistaState();
}
class MemoriaVistaState extends State<MemoriaVista>{
  final TextEditingController gigasController = TextEditingController();
  final MemoriaController  controller = MemoriaController();

  MemoriaModel? resultado;
  String error ='';

  void ejecutarCalculo(){
    FocusScope.of(context).unfocus();
    final resultadoejecucion = controller.procesar(gigasController.text);
    setState(() {
      if(resultadoejecucion!=null){
        resultado = resultadoejecucion;
        error = '';
      } else {
        resultado = null;
        error = 'Ingresa un valor valido';
      }
    });
  }

  @override
  void dispose(){
    gigasController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Expanded(child: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            const SizedBox(height: 10,),
            if(error.isNotEmpty)
              Text(error,
                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 10),
            MResultados(
              titulo: 'Megabytes (MB)',
              valor: resultado?.megabytes.toStringAsFixed(2) ?? '0.00',
              icono: Icons.sd_storage,
              color: widget.colorTema,
            ),
            MResultados(
              titulo: 'Kilobytes (KB)',
              valor: resultado?.kilobytes.toStringAsFixed(2) ?? '0.00',
              icono: Icons.memory,
              color: widget.colorTema,
            ),
            MResultados(
              titulo: 'Bytes (B)',
              valor: resultado?.bytes.toStringAsFixed(2) ?? '0.00',
              icono: Icons.data_object,
              color: widget.colorTema,
            ),
          ],
        ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          color: Theme.of(context).scaffoldBackgroundColor, // Mismo color del fondo
          child: MIngreso(controlador: gigasController, calcular: ejecutarCalculo, colorTema: widget.colorTema,
          textoHint: 'Ingresa los Gigabytes...', icono: Icons.storage_rounded,),
        ),
      ],
    );
  }
}


class MemoriaView extends StatelessWidget{
  final Color micolor = const Color(0xFF1E28E9);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor'),
        backgroundColor: micolor,
        foregroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MemoriaVista(colorTema: micolor),
      ),
    );
  }

}



