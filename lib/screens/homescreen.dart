import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getGreeting() {
  // Get the current hour
  DateTime now = DateTime.now();
  int hour = now.hour;

  // Determine the appropriate greeting based on the time
  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Color(0xFFFEA33F)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context,state){
                if(state is WeatherSuccess){
                  return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text('${state.weather.areaName}')),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        getGreeting(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                    Image.asset(
                      'assets/${state.weather.weatherConditionCode! ~/100}.png',
                      scale: 3,
                    ),
                    Text(
                      '${state.weather.temperature!.celsius!.round()}°C',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white),
                    ),
                    Text(
                      '${state.weather.weatherMain}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Text(DateFormat('EEEE h a').format(DateTime.now())),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/6.png',
                              scale: 8,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [const Text('Sunrise'), Text('${state.weather.sunrise!.hour}:${state.weather.sunrise!.minute}')],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/12.png',
                              scale: 8,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [const Text('Sunset'), Text('${state.weather.sunset!.hour}:${state.weather.sunset!.minute}')],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/13.png',
                              scale: 8,
                            ),
                            const SizedBox(
                                //width: 5,
                                ),
                            Column(
                              children: [const Text('Temp Max'), Text('${state.weather.tempMax!.celsius!.round()}ºC')],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/14.png',
                              scale: 8,
                            ),
                            const SizedBox(
                                //width: 5,
                                ),
                            Column(
                              children: [const Text('Temp Min'), Text('${state.weather.tempMin!.celsius!.round()}ºC')],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
                }
                else{
                  return Container();
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
