import 'dart:ffi';

import 'package:flutter/material.dart';
import '../controller/conversion_controller.dart';
import '../model/conversion_model.dart';


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
        borderSide: BorderSide(color: Color(0xFFF19595)),
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

  MIngreso({super.key, required this.controlador, required this.calcular, required this.colorTema
  });
    @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
        child: ATextField(controlador: controlador, textoAyuda: 'Ingresa en metros...', icono: Icons.straighten,
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

class ConversorVista extends StatefulWidget{

  final Color colorTema;
  const ConversorVista({super.key, required this.colorTema
  });

  @override
  State<ConversorVista> createState() => ConversorVistaState();
}
class ConversorVistaState extends State<ConversorVista>{
  final TextEditingController metrosController = TextEditingController();
  final ConversionController controller = ConversionController();

  ConversionModel? resultado;
  String error ='';

  void ejecutarCalculo(){
    FocusScope.of(context).unfocus();
    final resultadoejecucion = controller.procesar(metrosController.text);
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
    metrosController.dispose();
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
    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    const SizedBox(height: 10),
    MResultados(
    titulo: 'Yardas', valor: resultado?.yardas.toStringAsFixed(2) ?? '0.00',
    icono: Icons.swap_calls, color: widget.colorTema,
    ),
    MResultados(
    titulo: 'Pies', valor: resultado?.pies.toStringAsFixed(2)?? '0.00',
    icono: Icons.nordic_walking, color: widget.colorTema,
    ),
    MResultados(
    titulo: 'Centímetros', valor: resultado?.centimetros.toStringAsFixed(2)?? '0.00',
    icono: Icons.space_bar, color: widget.colorTema,
    ),
    MResultados(
    titulo: 'Pulgadas', valor: resultado?.pulgadas.toStringAsFixed(2)?? '0.00',
    icono: Icons.compress, color: widget.colorTema,
    ),
      ],
    ),
    ),
    Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    color: Theme.of(context).scaffoldBackgroundColor, // Mismo color del fondo
    child: MIngreso(controlador: metrosController, calcular: ejecutarCalculo, colorTema: widget.colorTema
    ),
    ),
    ],
    );
  }
}


class ConversionVista extends StatelessWidget{
  final Color micolor = const Color(0xFFE91E63);

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
        child: ConversorVista(colorTema: micolor),
      ),
    );
  }

}



