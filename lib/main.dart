import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:http/http.dart' as http;

import 'models/api_result.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  static const buttonSize = 60.0;

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String input = '';
  var len = 0;
  static const PIN = '123456';
  var _num = PIN.length;
  //single source or truth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outlined,
                        size: 75,
                        color: Colors.pink.shade500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 40, color: Colors.pink.shade500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Enter PIN to login',
                          style: TextStyle(
                              fontSize: 30, color: Colors.pink.shade500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '$input',
                      style: TextStyle(
                          fontSize: 30, color: Colors.deepPurple.shade900),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Collection for filled
                        if (input.isNotEmpty)
                          for (var i = 0; i < len; i++) buildContainer2(),
                        // Collection for empty
                        for (var i = 0; i < _num; i++) buildContainer(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(1),
                      _buildButton(2),
                      _buildButton(3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(4),
                      _buildButton(5),
                      _buildButton(6),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(7),
                      _buildButton(8),
                      _buildButton(9),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: LoginPage.buttonSize,
                            height: LoginPage.buttonSize,
                          )),
                      _buildButton(0),
                      _buildButton(-1),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: 25.0,
      height: 25.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        shape: BoxShape.circle,
      ),
    );
  }

  Container buildContainer2() {
    return Container(
      width: 25.0,
      height: 25.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade400,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildButton(int n) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          if (n == -1) {
            //print('Backspace');
            setState(() {
              // '12345'
              var length = input.length;
              input = input.substring(0, length - 1);
              len = input.length;
              _num++;
            });
          } else {
            //print('$n');
            if (input.length < PIN.length) {
              setState(() {
                input = '$input$n';
                len = input.length;
                _num--;
                //print(input.compareTo('123456'));
              });
            }
            if (input.length == PIN.length) {
              var check = await _handleLogin();
              setState(() {
               if (!check) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Incorrect PIN'),
                          content: Text('Please try again'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      });
                  input = '';
                  _num = 6;
                } else {
                  // ให้แทน NextPage ด้วยชื่อคลาสของหน้าที่ต้องการ
                  // navigate ไป
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              });
            }
          }
        },
        borderRadius: BorderRadius.circular(LoginPage.buttonSize / 2),
        child: Container(
          width: LoginPage.buttonSize,
          height: LoginPage.buttonSize,
          //color: Colors.green, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว

          decoration: (n == -1)
              ? null
              : BoxDecoration(
                  color: Colors.pink.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0)),
          alignment: Alignment.center,
          // conditional operator (?:)
          child: (n == -1)
              ? Icon(Icons.backspace)
              : Text(
                  '$n',
                  style: TextStyle(fontSize: 20),
                ),
        ),
      ),
    );
  }

  Future<bool> _handleLogin() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pin': input}), //{'pin': input} <-- this is MAP
    ); //await คือ การแปลงเป็น response.then()ให้
    print(response.body);

    var json = jsonDecode(response.body);
        var api_re =  ApiResult.fromJson(json);
        //print(api_re);
    return api_re.data;


    //response.then((response) => print(response.body)); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน
    //response.then(_handleResponse); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน

    //var i =0;
    //Above code is 'Asynchronous programming'
    /*   EX. โปรแกรมเรียกฟังก์ชัน A(); และ B();
    โปรแกรมจะรันฟังก์ชัน A(); และ B(); ตามลำดับ
    โดยไม่สนใจว่าฟังก์ชัน A(); จะทำงานเสร็จรึยัง
    จะไปเรียกฟังก์ชัน B(); ต่อเลยทันที*/
  }
}
