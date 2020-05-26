import 'package:RickAndMortyFlutter/pages/CharacterDetails.dart';
import 'package:flutter/material.dart';
import './pages/CharacterList.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty Flutter',
      home:  Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () { 
                if(_navigator.currentState.canPop())
                  _navigator.currentState.pop(context);
              },
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage("https://cdn.seara.com/unkind.pt/fotos/familias/96ar48nf_1494673883.jpg"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            )
          ),

          Expanded(
            flex: 5,
            child: Container(
              color: Color(0xff24282a),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigator,
                initialRoute: 'characterList',
                routes: {
                  'characterList': (context) => Container(child: CharacterList()),
                  '/characterDetails': (context) => CharacterDetails(),
                },
              )
            )
          )
        ],
      )
    );
  }
}

