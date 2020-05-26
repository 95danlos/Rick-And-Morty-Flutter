import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  var endOfListController = ScrollController(); 
  var characters = List();
  var filteredCharacters = List();
  var isLoading = false;
  var searchKey = "";
  var nextURL = "https://rickandmortyapi.com/api/character";

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    endOfListController.addListener(() {
      if (endOfListController.position.atEdge) {
        if (endOfListController.position.pixels != 0)
          fetchCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            width: 300,
            child: TextField(
              style: TextStyle(color: Colors.grey, fontSize: 20),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff24282a), width: 0.0),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff24282a), width: 0.0),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                hintText: 'Enter a Name..',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                fillColor: Color(0xff414141),
                filled: true,
              ),
              onChanged: (text) {
                filterCharactersBySearchkey(text);
              },
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                if(filteredCharacters.length > 0)
                  Expanded(
                    child: ListView.builder(
                      controller: endOfListController,
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredCharacters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () { 
                              Navigator.pushNamed(
                                context,
                                '/characterDetails',
                                arguments: filteredCharacters[index],
                                );
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.all(15),
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(filteredCharacters[index]["image"]),
                                ),
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                alignment: Alignment.center,
                                height: 30,
                                width: 200,
                                child: Text(
                                  filteredCharacters[index]["name"],
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                  )
                              ),
                            )
                          )
                        );
                      }
                    )
                  ),
                if(isLoading)
                  Center(
                    child: Container( 
                      child: CircularProgressIndicator(),
                      margin: EdgeInsets.all(15),
                    )
                  )
              ],
          )
          )
        ],
      )
    ); 
  }


  fetchCharacters() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(nextURL);
    setState(() {
      characters = characters + jsonDecode(response.body.toString())["results"];
      nextURL = jsonDecode(response.body.toString())["info"]["next"];
      isLoading = false;
    });
    filterCharactersBySearchkey(searchKey);
  }


  filterCharactersBySearchkey(key) {
    setState(() {
      searchKey = key;
      filteredCharacters = List.from(characters.where((character) => 
        character["name"].toLowerCase().contains(key.toLowerCase())));
    });
  }
}

