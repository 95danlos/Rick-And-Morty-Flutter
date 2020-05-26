import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CharacterDetails extends StatefulWidget {
  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  var characterLocationInfo;
  var character;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    character = jsonDecode(jsonEncode(ModalRoute.of(context).settings.arguments));
    if(characterLocationInfo == null)
      fetchCharacterLocationInfo();

    return Scaffold(
      backgroundColor: Color(0xff505050),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(character["image"]),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          character["name"],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "Status: " + character["status"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )
                  )
                ,)
              ],
            ),
            if(characterLocationInfo != null)
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 20),
                        child: Text(
                          "Profile",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Gender",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          character["gender"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Species",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          character["species"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Origin",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          character["origin"]["name"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 20),
                        child: Text(
                          "Location",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Name",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          characterLocationInfo["name"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Type",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          characterLocationInfo["type"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          "Dimension",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          characterLocationInfo["dimension"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white
                      ),
                    ],
                  )
                )
              ],
            )
            else
              Center(
                child: Container( 
                  child: CircularProgressIndicator(),
                  margin: EdgeInsets.all(15),
                )
              )
          ],
        ),
      )
    );
  }

  fetchCharacterLocationInfo() async {
    var response = await http.get(character["location"]["url"]);
    setState(() {
      characterLocationInfo = jsonDecode(response.body.toString());
    });
  }
}


