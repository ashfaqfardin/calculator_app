import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";

  void _onButtonPressed(String buttonText) {
    if (buttonText == "IconData(U+0E353)") {
      return;
    }
    setState(() {
      if (buttonText == "c") {
        equation = "0";
        result = "0";
      } else if (buttonText == "x") {
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget calculatorButton(dynamic buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
          backgroundColor: buttonColor,
        ),
        onPressed: () => _onButtonPressed(buttonText is String ? buttonText : buttonText.icon.toString()),
        child: buttonText is String
            ? Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        )
            : Icon(
          buttonText.icon,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Center(
            child: Column(
              children: [
                SizedBox(width: 10,),
                Text('Calculator'),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0e2433),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: const TextStyle(fontSize: 34.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 55),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                result,
                style: const TextStyle(fontSize: 48.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        calculatorButton(const Icon(Icons.keyboard_arrow_down), 1, const Color(0xff0b344f)),
                        calculatorButton("c", 1, const Color(0xff0b344f)),
                        calculatorButton("x", 1, const Color(0xff0b344f)),
                      ]),
                      TableRow(children: [
                        calculatorButton("(", 1, const Color(0xff0b344f)),
                        calculatorButton(")", 1, const Color(0xff0b344f)),
                        calculatorButton("%", 1, const Color(0xff0b344f)),
                      ]),
                      TableRow(children: [
                        calculatorButton("1", 1, const Color(0xff0b344f)),
                        calculatorButton("2", 1, const Color(0xff0b344f)),
                        calculatorButton("3", 1, const Color(0xff0b344f)),
                      ]),
                      TableRow(children: [
                        calculatorButton("4", 1, const Color(0xff0b344f)),
                        calculatorButton("5", 1, const Color(0xff0b344f)),
                        calculatorButton("6", 1, const Color(0xff0b344f)),
                      ]),
                      TableRow(children: [
                        calculatorButton("7", 1, const Color(0xff0b344f)),
                        calculatorButton("8", 1, const Color(0xff0b344f)),
                        calculatorButton("9", 1, const Color(0xff0b344f)),
                      ]),
                      TableRow(children: [
                        calculatorButton("0", 1, const Color(0xff0b344f)),
                        calculatorButton("00", 1, const Color(0xff0b344f)),
                        calculatorButton(".", 1, const Color(0xff0b344f)),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [calculatorButton("/", 1, const Color(0xff0b344f))]),
                      TableRow(children: [calculatorButton("*", 1, const Color(0xff0b344f))]),
                      TableRow(children: [calculatorButton("-", 1, const Color(0xff0b344f))]),
                      TableRow(children: [calculatorButton("+", 1, const Color(0xff0b344f))]),
                      TableRow(children: [calculatorButton("=", 2, const Color(0xff296d98))]),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const CalculatorScreen());
}
