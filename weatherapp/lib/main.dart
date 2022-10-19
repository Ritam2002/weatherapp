import 'package:flutter/material.dart';
import 'package:weatherapp/services/api_helper.dart';
import 'package:weatherapp/services/gps_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = '';
  double temp = 0.0;
  int humidity = 0;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'Images/weather.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Color.fromARGB(0, 103, 70, 70),
          appBar: AppBar(
            backgroundColor: Colors.black54.withOpacity(0.5),
            title: Text('Todays Weather'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'Images/cloud6.png',
                  width: 400,
                  height: 400,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      onChanged: (value) {
                        city = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Location',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var r = await ApiHelper(city).call_api();
                    GpsHelper gps = GpsHelper();
                    await gps.get_location();
                    print(r);
                    setState(() {
                      temp = r['current']['temp_c'];
                      humidity = r['current']['humidity'];
                      latitude = gps.latitude;
                      longitude = gps.longitude;
                    });
                  },
                  child: Text('Search'),
                ),
                Text('Temperature: ${temp}'),
                Text('Humidity: ${humidity}'),
                Text('Latitude: ${latitude}'),
                Text('Longitude: ${longitude}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
