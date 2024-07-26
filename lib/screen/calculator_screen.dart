
import 'package:calculator/model/calculator_model.dart';
import 'package:calculator/widgets/button_values_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final calculator = Provider.of<CalculatorModel>(context);
    return  Scaffold(
      body:SafeArea(
        bottom: false,
        child: Column(
          children: [
            //output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16.0),
                  child:  Text(
                    "${calculator.number1}${calculator.operand}${calculator.number2}".isEmpty
                    ?"0"
                    :"${calculator.number1}${calculator.operand}${calculator.number2}",
                  style: const TextStyle(
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            //buttons
            Wrap(
              children: 
              Btn.buttonValues
              .map(
                (value) => SizedBox(
                  width:value == Btn.n0
                  ?screenSize.width/2
                  :(screenSize.width/4),
                  height:screenSize.width/5,
                  child: buildButton(value),
                ),
                )
                .toList(),
            )
          ],
        ),
      )
    );
  }

Widget buildButton(value) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      color: getBtnColor(value),
      clipBehavior: Clip.hardEdge,
      shape: OutlineInputBorder(
        borderSide:const BorderSide(
          color: Colors.white24
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: InkWell(
        onTap: () => onBtnTap(value),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
          ),
        )
      ),
    ),
  );
 }
 void onBtnTap(String value) {
  final calculator = Provider.of<CalculatorModel>(context,listen:false);

  if (value == Btn.del) {
    calculator.delete();
    return;
  }

  if (value == Btn.clr) {
    calculator.clearAll();
    return;
  }

  if (value == Btn.per) {
    calculator.convertToPercentage();
    return;
  }

  if (value == Btn.calculate) {
    calculator.calculate();
    return;
  }

  calculator.appendValue(value);
 }
}


Color getBtnColor(value) {
  return [Btn.del,Btn.clr].contains(value)?Colors.blueGrey:
      [
        Btn.per,
        Btn.multiply,
        Btn.add,
        Btn.subtract,
        Btn.divide,
        Btn.calculate,
        ].contains(value)?Colors.orange:Colors.black87;
}

