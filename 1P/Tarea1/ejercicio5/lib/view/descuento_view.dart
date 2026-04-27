import 'package:flutter/material.dart';
import '../controller/descuento_controller.dart';

// Colores

class AppColors {
  static const mint = Color(0xFFADF5D7);
  static const teal = Color(0xFF88F2DA);
  static const skyLight = Color(0xFF84D2F2);
  static const sky = Color(0xFF6CB6EC);
  static const blue = Color(0xFF5F89C5);
  static const white = Colors.white;
  static const textDark = Color(0xFF1A3A5C);
  static const textMid = Color(0xFF2E6090);
}

// Átomos

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
        letterSpacing: 0.5,
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;

  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textMid,
        letterSpacing: 0.25,
      ),
    );
  }
}

class MoneyField extends StatelessWidget {
  final TextEditingController moneyController;

  const MoneyField({super.key, required this.moneyController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: moneyController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(fontSize: 16, color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: TextStyle(color: AppColors.sky.withOpacity(0.5)),
        prefixIcon: const Icon(Icons.attach_money, color: AppColors.blue),
        filled: true,
        fillColor: AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.skyLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.sky, width: 2),
        ),
      ),
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController numberController;

  const NumberField({super.key, required this.numberController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: numberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Número aleatorio',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class ResultLabel extends StatelessWidget {
  final String result;

  const ResultLabel({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return const SizedBox.shrink();
    }

    final isError = !result.contains('Número');
    return Text(
      result,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        height: 1.7,
        fontWeight: FontWeight.w500,
        color: isError ? Colors.red.shade700 : AppColors.textDark,
      ),
    );
  }
}

// Moléculas

class TotalInput extends StatelessWidget {
  final TextEditingController totalController;

  const TotalInput({super.key, required this.totalController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(text: 'Ingrese el total de su compra'),
        const SizedBox(height: 10),
        MoneyField(moneyController: totalController),
      ],
    );
  }
}

class RandomInput extends StatelessWidget {
  final TextEditingController randomController;

  const RandomInput({super.key, required this.randomController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(text: 'Número aleatorio (se generará automáticamente)'),
        const SizedBox(height: 10),
        NumberField(numberController: randomController),
      ],
    );
  }
}

// Organismo

class DescuentoCard extends StatefulWidget {
  @override
  State<DescuentoCard> createState() => DescuentoCardState();
}

class DescuentoCardState extends State<DescuentoCard> {
  final TextEditingController totalController = TextEditingController();
  final DescuentoController descuentoController = DescuentoController();
  String result = '';

  void calcularDescuento() {
    setState(() {
      result = descuentoController.calcular(totalController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.sky.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const TitleText(text: "Promoción Supermercado"),
          const SizedBox(height: 24),
          TotalInput(totalController: totalController),
          const SizedBox(height: 20),
          Button(text: 'Calcular Descuento', onPressed: calcularDescuento),
          const SizedBox(height: 20),
          ResultLabel(result: result),
        ],
      ),
    );
  }
}

// Página

class DescuentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyLight,
      appBar: AppBar(
        title: const Text(
          'Descuento Supermercado',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.skyLight,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.textMid,
      ),
      body: Center(child: SingleChildScrollView(child: DescuentoCard())),
    );
  }
}
