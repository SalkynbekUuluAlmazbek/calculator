import 'package:calculator/widgets/button_values_widget.dart';
import 'package:flutter/material.dart';


class CalculatorModel extends ChangeNotifier {
  String _number1 = "";  // .0-9
  String _operand = "";   // - + * /
  String _number2 = "";   // .0-9

  String _lastOperand = "";
  String _lastOperator = "";

  String get number1 => _number1;
  String get operand => _operand;
  String get number2 => _number2;

void appendValue(String value) {

  if (value != Btn.dot && int.tryParse(value) == null) {
    if (_operand.isNotEmpty && _number2.isNotEmpty) {
      calculate();
      
    }
    _operand = value;
  } else if (_number1.isEmpty || _operand.isEmpty) {
    //
    if (value == Btn.dot && _number1.contains(Btn.dot)) return;
    if (value == Btn.dot && (_number1.isEmpty || _number1 == Btn.n0)) {
      value = "0.";

    }
    _number1 += value;

  } else if (_number2.isEmpty || _operand.isNotEmpty) {
    //
    if (value == Btn.dot && _number2.contains(Btn.dot)) return;
    if (value == Btn.dot && (_number2.isEmpty || _number2 == Btn.n0)) {
      value = "0.";

    }
    _number2 += value;
  }
  notifyListeners();

 }

 void clearAll() {
    _number1 = "";
    _operand = "";
    _number2 = "";
    _lastOperator = "";
    _lastOperand = "";
    notifyListeners();
 }

 void convertToPercentage() {
  if (_number1.isNotEmpty && _operand.isNotEmpty && _number2.isNotEmpty) {
    calculate();
  }
  if (_operand.isNotEmpty) {
  }
  final number = double.parse(_number1);
    _number1 = "${(number / 100)}";
    _operand = "";
    _number2 = "";
    notifyListeners();
}

void calculate() {
  if (_number1.isEmpty) return;
  if (_operand.isEmpty && _lastOperator.isEmpty) return;
  if (_number2.isEmpty && _lastOperand.isEmpty) return;

  final num1 = double.parse(_number1);
  final num2 = _number2.isEmpty ? double.parse(_lastOperand) : double.parse(_number2);

  var result = 0.0;
  switch (_operand.isEmpty ? _lastOperator : _operand) {
    case Btn.add:
    result = num1 + num2;
      break;
      case Btn.subtract:
      result  = num1 - num2;
      break;
      case Btn.multiply:
      result = num1 * num2;
      break;
      case Btn.divide:
      result = num1 / num2;
      break;
    default:
  }
    _number1 = "$result";

    if (_number1.endsWith(".0")) {
      _number1 = _number1.substring(0, _number1.length - 2);
    }

    _lastOperator = _operand.isEmpty ? _lastOperator : _operand;
    _lastOperand = _number2.isEmpty ? _lastOperand : _number2;

    _operand = "";
    _number2 = "";
    notifyListeners();
  }

  void delete(){
  if (_number2.isNotEmpty){
    _number2 = _number2.substring(0, _number2.length - 1);
  } else if (_operand.isNotEmpty) {
    _operand = "";
  } else if (_number1.isNotEmpty) {
    _number1 = _number1.substring(0, _number1.length - 1);
  }
  notifyListeners();
 }

}
