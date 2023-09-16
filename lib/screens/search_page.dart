import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

import '../cubits/weather_cubit/weather_cubit.dart';

class SearchPage extends StatelessWidget {

  String? cityName;
  // SearchPage({this.updateUi});
  // VoidCallback? updateUi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (data){
              cityName = data;
            },
            onSubmitted: (data) async{
              cityName = data;

              BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);

              /*WeatherService service = WeatherService();
              WeatherModel? weatherModel = await service.getWeather(cityName: cityName!);
              Provider.of<WeatherProvider>(context, listen: false).weatherData = weatherModel;
              Provider.of<WeatherProvider>(context, listen: false).cityName = cityName;
              Navigator.pop(context);*/
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 34, bottom: 34, left: 25, right: 25),
              label: Text('Search'),

              suffixIcon: GestureDetector(
                onTap: () async{
                  BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
                  BlocProvider.of<WeatherCubit>(context).cityName = cityName;
                  Navigator.pop(context);

                  /*WeatherService service = WeatherService();
                  WeatherModel? weatherModel = await service.getWeather(cityName: cityName!);
                  Provider.of<WeatherProvider>(context, listen: false).weatherData = weatherModel;
                  Provider.of<WeatherProvider>(context, listen: false).cityName = cityName;
                  Navigator.pop(context);*/
                },
                  child: Icon(Icons.search)),
              border: OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }

}

