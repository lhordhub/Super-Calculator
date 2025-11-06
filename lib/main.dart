import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  int _calculateCount = 0; // Move _calculateCount here

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _output = '';
      } else if (buttonText == '⌫') {
        _output =
            _output.isNotEmpty ? _output.substring(0, _output.length - 1) : '';
      } else if (buttonText == '=') {
        _calculateCount++;
        switch (_calculateCount) {
          case 1:
            _output = 'Nagkaon kana lab?';
          case 2:
            try {
              Parser p = Parser();
              Expression exp = p.parse(_output);
              ContextModel cm = ContextModel();
              double eval = exp.evaluate(EvaluationType.REAL, cm);
              _output = eval.toString();
            } catch (e) {
              _output = 'Error';
            }
            break;
          case 3:
            _output = 'sori ha, saba jud sila diri ba';
            break;
          default:
            _output = 'I miss youu, MUAHHHHH';
            _calculateCount = 0; // Reset counter after the last output
            break;
        }
      } else {
        _output += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 19,
        title: Row(
          children: [
            Text(
              'Lhord Green',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 0),
            Icon(
              Icons.flag,
              color: Colors.green,
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, color: Colors.orange),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('AC', flex: 1, color: Colors.red),
              _buildButton('⌫', flex: 1, color: Colors.red),
              Spacer(),
              _buildButton('/', flex: 1, color: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('*', color: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-', color: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('+', color: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('.', flex: 1),
              _buildButton('0', flex: 1),
              _buildButton('=', flex: 2, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText,
      {int flex = 1, Color color = Colors.white}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonText == '=' ? Colors.orange : Colors.black,
            shape: RoundedRectangleBorder(),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: buttonText == 'AC' ? 18 : 24,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
