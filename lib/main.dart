import 'dart:async';
//import 'dart:ffi';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoppingmallbydew/states/my_map.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool stop = true;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  bool find = false;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  double? lat, lng;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Cerrent Location'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('add my location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location')),
          TextButton(
              onPressed: () {
                _delete();
              },
              child: Text('Delete Collection "Getlocation"')),
          TextButton(
              onPressed: () {
                _deleteDataFormNB();
              },
              child: Text('Delete Collection "traffic"')),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Getlocation')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['time'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.directions),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyMap(snapshot.data!.docs[index].id)));
                          }),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

 

  _getLocation() async {
    stop = true;
     var firebaseUser = FirebaseAuth.instance.currentUser;
    final loc.LocationData _locationResult = await location.getLocation();
    final firestoreInstance = FirebaseFirestore.instance;
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation ) async {
      var now = DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now());
      var lat = currentlocation.latitude;
      var long = currentlocation.longitude;
      firestoreInstance.collection("Getlocation").add({
        "latitude": lat.toString(),
        "longitude": long.toString(),
        "time": now,
      }).then((value) {});
     
    });


    /****var firebaseUser = FirebaseAuth.instance.currentUser;
    final loc.LocationData _locationResult = await location.getLocation();
    final firestoreInstance = FirebaseFirestore.instance;
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      while (stop) {
        var now = DateFormat.yMd().add_jms().format(DateTime.now());
        var lat = currentlocation.latitude;
        var long = currentlocation.longitude;
        firestoreInstance.collection("Getlocation").add({
          "latitude": lat,
          "longitude": long,
          "time": now,
        }).then((value) {});
        
      }
      //await Future.delayed(Duration(seconds: 1));
    });*******/

    /*while (stop) {
      final loc.LocationData Position = await location.getLocation();
      var now = DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now());
      var lat = Position.latitude;
      var long = Position.longitude;
     var  latti = lat.toString();
     var longi = long.toString();
      addLLT.add({"latitude": latti, "longitude": longi, "time": now});
      setState(() {
        "latitude : $latti";
        "longitude : $longi";
        "time : $now";
      });
      await Future.delayed(Duration(seconds: 1));
    }*/

    //String add = 'Add Location';
    /*stop = true;
    try {
      while (stop) {
        final  loc.LocationData _locationResult = await location.getLocation();
        var now = DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now());
        var lat = _locationResult.latitude;
        var long = _locationResult.longitude;
        await FirebaseFirestore.instance.collection('Getlocation').doc().set({
          'latitude': lat.toString(),
          'longitude': long.toString(),
          'time': now,
        }, SetOptions(merge: true));
        await Future.delayed(Duration(seconds: 1));
      }
    } catch (e) {
      print(e);
    }*/
  }

  _stopListening() {
    stop = false;
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _delete() async {
    //String add = 'Add Location';
    try {
      var collection = FirebaseFirestore.instance.collection('Getlocation');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  _deleteDataFormNB() async {
    //String add = 'Add Location';

    try {
      var collection = FirebaseFirestore.instance.collection('traffic');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
