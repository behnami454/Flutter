import 'package:flutter/material.dart';
import 'package:firstflutter/classes/image_class.dart' as ima;
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = 'DetailsPage';

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments as String;
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
        appBar: AppBar(
          title: const Text('details'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.black87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.file(
                    image.image,
                    fit: BoxFit.cover,
                    width: 400,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.red,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text('You Have Saved This Photo at :',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(imageId.split(".").first),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
