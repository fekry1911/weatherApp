import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/bloc/states/weatherStates.dart';
import 'package:weatherapp/core/data/networkData/locationData.dart';
import 'package:weatherapp/core/data/networkData/weatherapi.dart';
import 'package:weatherapp/features/model/WeatherModel.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(InitialWeatherState());

  static WeatherCubit get(context) => BlocProvider.of(context);

  WeatherModel model = WeatherModel();
  List<Hour> hours = [];
  String? date;
  bool Search = false;
  List<String> country=[
    "Moscow",
    "London",
    "Berlin",
    "Berlin",
    "Rome",
    "Paris",
    "Baghdad",
    "Riyadh",
    "Cairo",
    "Ankara",
  ];
  WeatherModel modelSearch = WeatherModel();
  List<Hour> hoursSearch = [];



  void GetCurrentWeatherData({required lon, required lat}) {
    DioHelper.getData(
      url: "/forecast.json",
      query: {
        "key": "c1e8528f58774f589d0180616250303",
        "q": "37.4219983,-122.084",
      },
    ).then((onValue) {
      model = WeatherModel.fromJson(onValue.data);
      hours = model.forecast!.forecastday![0].hour!;
      emit(GetWeatherLocationDataSuc());
    });
  }
  void fetchLocation() async {
    hours=[];
    await getCurrentLocation().then((onValue) {
      emit(GetWeatherLocationDataSuc());
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEEE, d MMM').format(now);
      print(formattedDate);
      date = formattedDate;
      GetCurrentWeatherData(lat: onValue?.latitude, lon: onValue?.longitude);
    });
  }

  void GetSearchWeather({required String name}) {
    emit(InitialWeatherNameState());
    DioHelper.getData(
      url: "/forecast.json",
      query: {"key": "c1e8528f58774f589d0180616250303", "q": name},
    ).then((onValue) {
      modelSearch = WeatherModel.fromJson(onValue.data);
      hoursSearch = modelSearch.forecast!.forecastday![0].hour!;
      print(modelSearch.current!.condition!.icon!);
      emit(GetWeatherNameDataSuc());
    });
  }
  void clear(){
    hoursSearch=[];
    emit(EmpityState());
  }
}
