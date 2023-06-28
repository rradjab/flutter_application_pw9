import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw9/services/get_hotel_info.dart';

class HotelInfo extends StatefulWidget {
  const HotelInfo({super.key, required this.uuid, required this.title});
  final String uuid;
  final String title;

  @override
  State<HotelInfo> createState() => _HotelInfoState();
}

class _HotelInfoState extends State<HotelInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: getHotelInfo(widget.uuid),
        builder: (context, snapshot) {
          var hInfo = snapshot.data;
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: hInfo?.photos?.length ?? 0,
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    itemBuilder: (context, index, realIdx) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                              'assets/images/${hInfo?.photos?[index]}',
                              fit: BoxFit.cover,
                              width: 1000));
                    },
                  ),
                  const Divider(),
                  StyledText(
                      mainText: 'Страна: ', infoText: hInfo?.address?.country),
                  StyledText(
                      mainText: 'Город: ', infoText: hInfo?.address?.city),
                  StyledText(
                      mainText: 'Улица: ', infoText: hInfo?.address?.street),
                  StyledText(
                      mainText: 'Рейтинг: ',
                      infoText: hInfo?.rating.toString()),
                  const Divider(),
                  const Text('Сервисы', style: TextStyle(fontSize: 25.0)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Платные',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              ...?hInfo?.services?.paid
                                  ?.map((e) => Text(e))
                                  .toList(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Бесплатно',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              ...?hInfo?.services?.free
                                  ?.map((e) => Text(e))
                                  .toList(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Ошибка'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String mainText;
  final String? infoText;
  const StyledText({super.key, required this.mainText, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Text(mainText),
          Text(
            infoText.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
