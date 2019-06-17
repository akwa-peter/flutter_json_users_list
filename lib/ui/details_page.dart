import 'package:flutter/material.dart';
import 'package:user_list_json/User.dart';

class DetailsPage extends StatelessWidget{

  final User user;

  DetailsPage(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(user.name),
      ),

      body: new Container(
        child: new Row(

        ),
      ),
    );
  }

}