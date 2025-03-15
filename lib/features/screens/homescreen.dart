import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapp/core/bloc/cubit/weatherCubit.dart';
import 'package:weatherapp/core/bloc/states/weatherStates.dart';
import 'package:weatherapp/features/compontnts/hours.dart';
import 'package:weatherapp/features/screens/searchScreen.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          var cubit = WeatherCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.hours.isEmpty,
            builder: (context) {
              return Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color(0xFF1A1A3F),
                  rightDotColor: const Color(0xFFEA3799),
                  size: 50,
                ),
              );
            },
            fallback: (context) {
              return Column(
                children: [
                  Expanded(
                    flex: cubit.Search ? 6 : 5,
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
                          children: [
                            Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(text: 'F'),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  minFontSize: 5,
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            size: width * .08,
                                            color: Colors.white,
                                          ),
                                        ),
                                        AutoSizeText.rich(
                                          TextSpan(
                                            text:
                                                '${cubit.model.location!.name}',
                                          ),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          minFontSize: 5,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                Spacer(),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchscreen()));

                                }, icon:Icon(
                                  Icons.search,
                                  size: width * .08,
                                  color: Colors.white,
                                ),)
                              ],
                            ),
                            Container(
                              height: height * .24,
                              child: Image.network(
                                fit: BoxFit.fill,
                                "https:${cubit.model.current!.condition!.icon!}",
                              ),
                            ),
                            AutoSizeText.rich(
                              TextSpan(
                                text: "${cubit.model!.current!.tempC}",
                              ),
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              minFontSize: 5,
                            ),
                            AutoSizeText.rich(
                              TextSpan(
                                text:
                                    '${cubit.model.current!.condition!.text!}',
                              ),
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              minFontSize: 5,
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
                                      "${cubit.model.current!.windKph} KM",
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
                                      "${cubit.model.current!.humidity!} %",
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
                                      "${cubit.model.forecast!.forecastday![0].day!.dailyChanceOfRain!} %",
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(text: 'Today'),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  minFontSize: 5,
                                ),
                                Spacer(),
                                AutoSizeText.rich(
                                  TextSpan(text: '7 days'),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  minFontSize: 5,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.fetchLocation();
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Hours(degree: cubit.hours[index].tempC, time: "$index:00", icon: cubit.hours[0].condition!.icon!,);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 10);
                                },
                                itemCount: cubit.hours!.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
