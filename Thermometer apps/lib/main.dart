import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thermometer/Advice.dart';
import 'package:thermometer/Home.dart';
import 'package:thermometer/News.dart';


void main() {runApp(MaterialApp(
  home: Homepage(),
)
);
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IF-nity SDN.BHD'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image:DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1503435980610-a51f3ddfee50?ixlib=rb-1.2.1&w=1000&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        padding:const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
                child: Image.network('',
                  width: 300,
                  height: 300,
                  fit:BoxFit.fitWidth,
                  alignment: Alignment.bottomLeft,
                )
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)
                => MyApp()),);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: NBV(),

    );
  }
}

class NBV extends StatefulWidget {

  @override
  _NBVState createState() => _NBVState();
}

class _NBVState extends State<NBV> {
  int _currentIndex = 0;
  final List <Widget> _children = [
    Home(),
    News(),
    Advice(),


  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            title: Text('News'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text('Guideline'),

          ),

        ],

      ),
    );
  }
}