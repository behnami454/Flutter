import 'package:flutter/material.dart';
import 'package:firstflutter/plugins/input_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:firstflutter/classes/image_class.dart' as ima;
import 'package:firstflutter/pages/details_page.dart';
import '../api/weather_api.dart';
import '../model/weather_model.dart';

class HomePage extends StatefulWidget {
  WeatherModel? weather;
  var isLoaded = false;

  HomePage({Key? key, this.weather}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied) {
      final Position position = await Geolocator.getCurrentPosition();
      widget.weather = await WeatherApi.getWeather(position);
    }
    if (widget.weather != null) {
      setState(() {
        widget.isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () {
              Navigator.pushNamed(context, InputPage.routeName);
            },
            child: const Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          title: Row(children: [
            const Text('Imagel'),
            const Spacer(),
            Visibility(
              visible: widget.isLoaded,
              replacement: const CircularProgressIndicator(),
              child: Row(
                children: [
                  const Text('temp: '),
                  Text('${widget.weather?.main?.temp}'),
                ],
              ),
            ),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: Provider.of<ima.ImageFile>(context, listen: false)
                  .fetchImage(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<ima.ImageFile>(
                          child: const Center(
                              child: Text('Click The Button Down There')),
                          builder: (ctx, image, ch) => image.items.isEmpty
                              ? ch!
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (ctx, i) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GridTile(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, DetailsPage.routeName,
                                                arguments: image.items[i].id);
                                          },
                                          child: Image.file(
                                            image.items[i].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemCount: image.items.length,
                                ),
                        )),
        ));
  }
}
