import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : (ModalRoute.of(context)?.settings.arguments as Map);

    String bgImage = data['isDayTime'] ? 'Day_image.jpg' : 'night_time.jpg';

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xff542200)));
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CarouselSlider(
              items: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/$bgImage'),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Column(
                      children: <Widget>[
                        TextButton.icon(
                          onPressed: () async {
                            dynamic result =
                                await Navigator.pushNamed(context, '/location');
                            setState(() {
                              data = {
                                'time': result['time'],
                                'location': result['location'],
                                'isDayTime': result['isDayTime'],
                                'flag': result['flag'],
                              };
                            });
                          },
                          icon: const Icon(
                            Icons.edit_location_alt,
                            color: Colors.white,
                          ),
                          label: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.purple,
                                    width: 4,
                                    style: BorderStyle.solid),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Text(
                              'Edit location here...',
                              style: TextStyle(
                                fontFamily: 'IndieFlower',
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data['location'],
                              style: const TextStyle(
                                  fontFamily: 'TiltPrism',
                                  fontSize: 30,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          data['time'],
                          style: const TextStyle(
                              fontSize: 65.0,
                              fontFamily: 'TiltPrism',
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                pauseAutoPlayOnTouch: true,
                height: MediaQuery.of(context).size.height,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                initialPage: 0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.decelerate,
                // enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
