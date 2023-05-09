import 'package:flutter/material.dart';
import 'package:world_time/pages/list_of_locations.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

bool isIconBool = false;
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  
  primarySwatch: Colors.purple,
  brightness: Brightness.light,
);
ThemeData darkTheme = ThemeData(
  
  primarySwatch: Colors.pink,
  brightness: Brightness.dark,
);

class _ChooseLocationState extends State<ChooseLocation> {
  LocationList myLocationList = LocationList();

  void updateTime(index) async {
    WorldTime instance = myLocationList.locations[index];
    await instance.getTime();
    if (!mounted) return;
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: isIconBool ? darkTheme : lightTheme,
     debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isIconBool = !isIconBool;
                });
              },
              icon: Icon(isIconBool ? iconDark : iconLight),
            ),
          ],
          backgroundColor: Colors.blue[900],
          title: const Text('Choose a location'),
          
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: myLocationList.locations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(
                      myLocationList.locations[index].location,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/${myLocationList.locations[index].flag}'),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
