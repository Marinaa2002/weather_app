import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';



class HomePage extends StatelessWidget {

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SearchPage(

              );
            }));
          }, icon: Icon(Icons.search))
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state){
          if(state is WeatherLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is WeatherSuccess){
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      weatherData!.getTheme(),
                      weatherData!.getTheme()[200]!,
                      weatherData!.getTheme()[100]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 3,),
                  Text(BlocProvider.of<WeatherCubit>(context).cityName!, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                  Text('Updated: ${weatherData!.date}',style: TextStyle(fontSize: 23)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text('${weatherData!.temp.toInt()}', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                      Column(
                        children: [
                          Text('maxTemp: ${weatherData!.maxTemp.toInt()}', style: TextStyle(fontSize: 18,)),
                          Text('min Temp: ${weatherData!.minTemp.toInt()}', style: TextStyle(fontSize: 18,))
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Text(weatherData!.weatherStateName, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                  Spacer(flex: 5,)
                ],
              ),
            );
          }
          else if(state is WeatherFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'there is no weather 😔 start',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'searching now 🔍',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            );
          }
          else{
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'there is no weather 😔 start',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'searching now 🔍',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
