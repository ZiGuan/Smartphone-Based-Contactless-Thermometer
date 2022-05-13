import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  double _width = 200;
  double _height = 200;

  UsbPort _port;
  String _status = "Please Plug in the Device";
  List<Widget> _ports = [];
  String _serialData = '0';
  String app;

  double nom = 0;
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  int _deviceId;


  Color textColor = Colors.black;

  void dreading() {
    setState(() {
      _width = 250;
      _height = 250;


      app = _serialData;
      nom = double.parse(app);

      if ((nom > 38.0)) {
        textColor = Colors.red.withOpacity(0.5);
      } else {
        if ((nom < 38.0) & (nom > 37.0)) {
          textColor = Colors.deepOrangeAccent.withOpacity(0.5);
        } else {
          if ((nom < 37.0) & (nom > 36.0)) {
            textColor = Colors.lightGreenAccent.withOpacity(0.5);
          } else {
            textColor = Colors.cyanAccent.withOpacity(0.5);
          }
        }
      }
    });
  }

  var url = 'https://www.instagram.com/if_nity20/';
  var form = 'https://docs.google.com/forms/d/e/1FAIpQLSe6jT97JPbPqgRWuAXZ60i0Oc-ZFkotLGh9OcbydHpAhQKfVw/viewform?usp=pp_url';
  var view = 'https://docs.google.com/spreadsheets/d/1MemKXC8gVvY1JdSuy7hWdA8oNx45Yk56aCXmQ998-_I/edit?usp=sharing';

  void contact() async {
    if (await canLaunch(url)
    ) {
      await launch(url,
          universalLinksOnly: true);
    } else {
      throw "there was a problem";
    }
  }

  void fill() async {
    if (await canLaunch(form)
    ) {
      await launch(form,
          universalLinksOnly: true);
    } else {
      throw "there was a problem";
    }
  }

  void data() async {
    if (await canLaunch(view)
    ) {
      await launch(view,
          universalLinksOnly: true);
    } else {
      throw "there was a problem";
    }
  }


  createAlertDialog2(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          backgroundColor: Colors.black45,
          title: Text('IF-NITY',
              style: new TextStyle(
                color: Colors.cyanAccent,
              )),
          content: Container(

            child: Text(
              '''IF-nity SDN. BHD. is a global and non-profit company where we developed intelligent electronic products and solve society problems. We strive to improve life of the people to become better.''',
              textAlign: TextAlign.justify,
              style: new TextStyle(
                color: Colors.white,),
            ),

          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              color: Colors.cyanAccent,
              child: Text('Contact us'),
              onPressed: contact,
            )
          ]
      );
    });
  }


  Future<bool> _connectTo(device) async {
    _serialData = '0';

    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction.dispose();
      _transaction = null;
    }

    if (device == null) {
      _deviceId = null;
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (!await _port.open()) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }

    _deviceId = device.deviceId;
    await _port.setDTR(true);
    await _port.setRTS(true);
    await _port.setPortParameters(
        9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port.inputStream, Uint8List.fromList([13, 10]));

    _subscription = _transaction.stream.listen((String line) {
      setState(() {
        _serialData = line;
      });
    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print(devices);

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: Icon(Icons.usb),
          title: Text(device.productName),
          subtitle: Text(device.manufacturerName),
          trailing: RaisedButton(
            child:
            Text(_deviceId == device.deviceId ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(_deviceId == device.deviceId ? null : device)
                  .then((res) {
                _getPorts();
              });
            },
          )));
    });

    setState(() {
      print(_ports);
    });
  }

  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
  }

  @override
  void dispose() {
    super.dispose();
    _connectTo(null);
  }

//...................................................................


  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      theme: ThemeData(
        backgroundColor: Colors.cyanAccent,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      debugShowCheckedModeBanner: false,
      home: buildHomePage('home'),
    );
  } // homepage!!!

  Widget buildHomePage(String title) {
    final reading = Container(
      padding: EdgeInsets.all(10),
      child: Text('$nom °C',
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
    );

    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 10,
      height: 2,
    );


    final button = DefaultTextStyle.merge(style: descTextStyle,
      child: Container(padding: EdgeInsets.all(10),
        child: Row(children: <Widget>[
          RaisedButton.icon(
            onPressed: dreading,
            color: Colors.white,
            splashColor: Colors.cyanAccent,
            icon: Icon(Icons.add_circle),
            label: Text('Record Temperature',
              style: descTextStyle,
            ),
          ),
        ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );


    final important = AnimatedContainer(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: textColor,
        shape: BoxShape.circle,

      ),

      child: Center(child:
      reading,

      ),

    );


    return Scaffold(
      //backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(
          child: Text('IF-NITY',
            //color: Colors.
          ),
        ),
      ),
      body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://c.stocksy.com/a/dLx100/z9/466465.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                child: Column(
                    children: <Widget>[
                      Text(_ports.length > 0
                          ? "Available Serial Ports"
                          : "No serial devices available",
                        // ignore: deprecated_member_use
                        style: new TextStyle(fontSize: 12),
                        // ignore: deprecated_member_use
                      ),
                      ..._ports,
                      Text('Status:$_status\n'),
                      // ignore: deprecated_member_use
                      Container(child:
                      important,
                        margin: EdgeInsets.all(30),

                      ),

                      Container(child:
                      button,
                        margin: EdgeInsets.all(10),
                      ),

                    ]
                )
            ),
          ]
      ),

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.cyanAccent,
        overlayOpacity: 0.2,
        //curve: Curves.easeIn,
        children: [
          SpeedDialChild(
            child:Icon(Icons.add),
            label: "Record data",
            onTap: fill,
          ),

          SpeedDialChild(
            child:Icon(Icons.account_circle),
            label: "View data",
            onTap: data,
          ),

          SpeedDialChild(
            child:Icon(Icons.phone),
            label: "Contact Us",
            onTap: (){createAlertDialog2(context);
            },
          ),


        ],
      ),

    );
  }
}