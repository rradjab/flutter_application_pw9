import 'package:flutter/material.dart';
import 'package:flutter_application_pw9/services/get_hotels.dart';
import 'package:flutter_application_pw9/views/hotel_info_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Hotels'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isGrid = false;
                });
              },
              icon: const Icon(Icons.view_list_sharp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isGrid = true;
                });
              },
              icon: const Icon(Icons.grid_on_sharp),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getHotels(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Center(
                    child: isGrid
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Image.asset(
                                              'assets/images/${snapshot.data![index].poster}'),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(snapshot.data![index].name),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(pageBuilder:
                                                  (context, animation,
                                                      secondAnimation) {
                                                return HotelInfo(
                                                  uuid: snapshot
                                                      .data![index].uuid,
                                                  title: snapshot
                                                      .data![index].name,
                                                );
                                              }, transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                CurvedAnimation curved =
                                                    CurvedAnimation(
                                                        parent: animation,
                                                        curve:
                                                            Curves.slowMiddle);
                                                Animation<double> animate =
                                                    Tween<double>(
                                                            begin: 0.0,
                                                            end: 1.0)
                                                        .animate(curved);
                                                return FadeTransition(
                                                  opacity: animate,
                                                  child: child,
                                                );
                                              }),
                                            );
                                          },
                                          child: const Text('Подробнее')),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/${snapshot.data![index].poster}'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                snapshot.data![index].name),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation,
                                                            secondAnimation) {
                                                  return HotelInfo(
                                                    uuid: snapshot
                                                        .data![index].uuid,
                                                    title: snapshot
                                                        .data![index].name,
                                                  );
                                                }));
                                              },
                                              child: const Text('Подробнее'))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  )
                : snapshot.hasError
                    ? const Center(
                        child: Text('Ошибка'),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
          }),
    );
  }
}
