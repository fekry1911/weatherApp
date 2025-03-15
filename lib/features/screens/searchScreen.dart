import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapp/core/bloc/cubit/weatherCubit.dart';
import 'package:weatherapp/core/bloc/states/weatherStates.dart';
import 'package:weatherapp/features/compontnts/cardcity.dart';
import 'package:weatherapp/features/compontnts/hours.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<WeatherCubit, WeatherStates>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth * 0.8;
            var cubit = WeatherCubit.get(context);
            // Adjust width dynamically
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  onPressed: () {
                    cubit.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                ),
                title: Center(
                  child: SizedBox(
                    width: width.clamp(250, 600), // Min 250px, Max 600px
                    child: TextFormField(
                      onFieldSubmitted: (text) {
                        cubit.GetSearchWeather(name: text);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                elevation: 0,
              ),
              body: ConditionalBuilder(
                condition: cubit.hoursSearch.isNotEmpty,
                builder: (context) {
                  return ConditionalBuilder(
                    condition: state is! InitialWeatherNameState,
                    builder: (context) {
                      return Column(
                        children: [
                          Expanded(
                            flex: cubit.Search ? 6 : 5,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [Colors.blue, Colors.white],
                                    center: Alignment.center,
                                    radius: 3,
                                  ),
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText.rich(
                                        TextSpan(
                                          text: "${cubit.modelSearch.location!.name!}",
                                        ),
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        minFontSize: 5,
                                      ),
                                      Container(
                                        height: height * .24,
                                        child: Image.network(
                                          fit: BoxFit.fill,
                                          "https:${cubit.modelSearch.current!.condition!.icon!}",
                                        ),
                                      ),
                                      AutoSizeText.rich(
                                        TextSpan(
                                          text: "${cubit.modelSearch.current!.tempC}",
                                        ),
                                        style: TextStyle(
                                          fontSize: 70,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        minFontSize: 5,
                                      ),
                                      Center(
                                        child: AutoSizeText.rich(
                                          TextSpan(
                                            text:
                                            '${cubit.modelSearch.current!.condition!.text!}',
                                          ),
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                          ),
                                          minFontSize: 5,
                                        ),
                                      ),
                                      AutoSizeText.rich(
                                        TextSpan(text: cubit.date),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        minFontSize: 5,
                                      ),

                                      Divider(
                                        color: Colors.white,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.wind_power,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              Text(
                                                "${cubit.modelSearch.current!.windKph} KM",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "wind",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.water_drop_outlined,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              Text(
                                                "${cubit.modelSearch.current!.humidity!} %",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "humidity",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.snowing,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              Text(
                                                "${cubit.modelSearch.forecast!.forecastday![0].day!.dailyChanceOfRain!} %",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Chance of rain",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: (){
                            cubit.clear();
                          }, icon: Icon(Icons.close,color: Colors.white,size: 30,))

                        ],
                      );
                    },
                    fallback: (context) {
                      return Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF1A1A3F),
                          rightDotColor: const Color(0xFFEA3799),
                          size: 50,
                        ),
                      );
                    },
                  );
                },
                fallback: (context) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          cubit.GetSearchWeather(name: cubit.country[index]);
                        },
                        child: CardCity(
                          width: width,
                          city: cubit.country[index],
                        ),
                      );
                    },
                    itemCount: cubit.country.length,
                  );
                },
              ),
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
