import 'package:flutter/material.dart';
import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                userLocation == null
                    ? Text("Latitude: "+
                    userLocation["latitude"].toString() +"   Longitude: " +
                    userLocation["longitude"].toString())
                    : CircularProgressIndicator(),
                
                Text('Tap the button to send your location:',
                  style: TextStyle( color: Colors.grey),
                ),
                SizedBox(height: 20.0,),
                RawMaterialButton(
                  onPressed: () {
                    _getLocation().then((value) {
                      setState(() {
                        userLocation = value;
                      });
                    });
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
                  onPressed: (){},
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

class AddingContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Text('This is the end of the line!!'),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            MaterialButton(onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            },
              child: Text("Go back to home"),
            )
          ],
        ),
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
