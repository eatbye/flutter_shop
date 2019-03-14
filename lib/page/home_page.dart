import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();

  String showText = '文字展示';

  Future getHttp(String text) async {
    try {
      var data = {'name': text};
      Response response = await Dio().post(   //get更换为post可以用post方式提交数据
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  void getHttp1() async {
    try{
      Dio dio = Dio();
      dio.options.headers = httpHeaders;
      Response response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      return print(response);
    }catch(e){
      return print(e);
    }
  }

  void _http1Action(){
    getHttp1();
  }

  void _choiceAction() {
    print('开始选择');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('内容不能为空'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          showText = value['data']['name'].toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('测试'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '测试',
                    helperText: '请输入内容'),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('确认选择'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              RaisedButton(
                onPressed: getHttp1,
                child: Text('测试'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
