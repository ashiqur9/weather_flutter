import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory weatherFactory =
            WeatherFactory('70a89cbee0dd74184d565be95cd22849');
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherSuccess(weather: weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
