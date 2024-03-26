import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:weatherapp/cubits/weather/weather_cubit.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/pages/search_page.dart';
import 'package:weatherapp/widgets/error_dialog.dart';

import '../constants/constants.dart';
import '../cubits/temp_settings/temp_settings_cubit.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );

              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: _showWeather(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_rounded),
            label: '',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the floating action button
        },
        child: const Icon(Icons.minimize_rounded),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'NAV BAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(''),
              onTap: () {
                // Update UI based on drawer item selection
              },
            ),
            ListTile(
              title: Text(''),
              onTap: () {
                // Update UI based on drawer item selection
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _showWeather() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://tse2.mm.bing.net/th?id=OIP.4qs3Kcqv--v80EQ1XmRzJwAAAA&pid=Api&P=0&h=180',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
          fit: BoxFit.fill, // Adjust fit to fill the entire space
        ),
        const SizedBox(height: 40),
        Text(
          'Current Weather',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state.status == WeatherStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == WeatherStatus.error) {
              return Text(
                'Error: ${state.error.errMsg}',
                style: TextStyle(color: Colors.red),
              );
            } else if (state.status == WeatherStatus.initial) {
              return const Text('');
            } else {
              return Column(
                children: [
                  Text(
                    state.weather.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Temperature: ${state.weather.temp}°C',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Maximum Temperature: ${state.weather.tempMax}°C',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lowest Temperature: ${state.weather.tempMin}°C',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description: ${state.weather.description.titleCase}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
