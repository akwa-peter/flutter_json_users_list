import 'package:flutter/material.dart';
import 'package:user_list_json/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:user_list_json/ui/details_page.dart' as DetailsPage;

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        leading: Icon(Icons.menu),
        title: new Text("Users"),
        actions: <Widget>[
          new Icon(Icons.search),
          new Icon(Icons.more_vert),
        ],
      ),

      body: new Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.data == null){
              return Container(
                child: Center(
                  child: new Text("Loading..."),
                ),
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].picture
                        ),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: (){
                        Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailsPage.DetailsPage(snapshot.data[index]))
                        );
                      },
                    );
                  });
            }
          }
        ),
      )
    );
  }

  Future<List<User>> _getUsers() async {

      var data = await http.get("https://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");

      //here we fetch the data as a json file, which we can loop through to get the data we want
      var jsonData = json.decode(data.body);

      //Create an empty list to hold the list of users
      List<User> users = [];

      //get each user in the json data and add to the list of users created
      for(var u in jsonData){
        User user = User(u["index"], u["about"], u["name"], u["email"], u["picture"]);
        users.add(user);
      }

      print(users.length);

      return users;

  }

}