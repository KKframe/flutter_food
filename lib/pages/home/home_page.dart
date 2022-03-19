import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/api_result.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Map<String,dynamic> foodMap = {};
  List<dynamic> data=[];
  List<FoodItem> _foodList = [];
 /* List<int> price = [];
  List<String> img = [];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('FLUTTER FOOD')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _handleClickButton, //onPress ต้องใส่เป็นฟังก์ชัน ไม่ใช่ result จากฟังก์ชัน
                  child: const Text('LOAD FOODS DATA'),
                ),
              ],
            ),
          ),
            /*for(var i in  data)
              foodMap.addAll(data[i]);
              buildFoodList(),*/
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:  _foodList.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) => _buildListItem(context, index),
              ),
            )
        ],
      ),
    );
  }

Widget _buildListItem(BuildContext context, int index) {
  var foodItem = _foodList[index];
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(foodItem.image,width: 100,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(foodItem.name,style: TextStyle(fontSize: 20,color: Colors.pink.shade500),),
                              Text('${foodItem.price.toString()} บาท',style: TextStyle(fontSize: 15,color: Colors.pink.shade200,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
  Future<void> _handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var result = await http.get(url);  //await คือ การแปลงเป็น result.then()ให้
    print(result.body);
    var jj = jsonDecode(result.body); // decode เพื่อแปลงออกมาเป็นโครงสร้างในภาษา dart จะได้ List ของ Map
    /*String status = jj['status']; //jj['ชื่อ key'] ,String ห้าม null
    String? msg = jj['message'];
    data = jj['data'];*/
    var api_re = ApiResult.fromJson(jj);
    print(api_re.status);
    setState((){
        _foodList = api_re.data.map<FoodItem>((item) => FoodItem.fromJson(item)).toList();
      //Map<String,dynamic> ts={};
     /* for(var i in api_re.data){
        *//*ts = i;
       print('menu ${ts['name']} price ${ts['price']} img ${ts['image']}');
       name.add(ts['name']);
       price.add(ts['price']);
       img.add(ts['image']);*//*
       var foodItem = FoodItem.fromJson(i);
        _foodList.add(foodItem);
      }*/


    });

    //result.then((response) => print(response.body)); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน
    //result.then(_handleResponse); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน

    //var i =0;
    //Above code is 'Asynchronous programming'
    /*   EX. โปรแกรมเรียกฟังก์ชัน A(); และ B();
    โปรแกรมจะรันฟังก์ชัน A(); และ B(); ตามลำดับ
    โดยไม่สนใจว่าฟังก์ชัน A(); จะทำงานเสร็จรึยัง
    จะไปเรียกฟังก์ชัน B(); ต่อเลยทันที*/
  }
 /* void _handleResponse(http.Response response){
    print(response.body);
  }*/
}
