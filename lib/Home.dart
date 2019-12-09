import 'package:flutter/material.dart';
import 'package:location/location.dart';
//import 'package:resq/new.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
//    super.initState();
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
  }

  var location = new Location();
  Map<String, double> userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS APP',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Current Location :",
                  style: TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 15.0
                  ),
                ),
                SizedBox(height: 15.0,),
                userLocation == null
                    ? CircularProgressIndicator()
                    : Text("Latitude: " +
                    userLocation["latitude"].toString() +
                    "   Longitude: " +
                    userLocation["longitude"].toString()),
                Divider(height: 40.0,),
                Text('Tap the button to send your location:',
                  style: TextStyle( color: Colors.grey),
                ),
                SizedBox(height: 20.0,),
                RawMaterialButton(
                  onPressed: () {

                  },
                  child: new Icon(
                    Icons.warning,
                    color: Colors.redAccent,
                    size: 200.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 5.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(30.0),
                ),
                SizedBox(height: 40.0,),
                RaisedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/getcontacts');
                  },
                  shape: StadiumBorder(),
                  child: Text('Add your contacts'),
                ),
              ],
            ),
          )
      ),
    );
  }
}

Future<Map<String, double>> _getLocation() async {
  var currentLocation = <String, double>{};
  var location =new Location();
  try {
    currentLocation = await location.getLocation();
  } catch (e) {
    currentLocation = null;
  }
  return currentLocation;
}