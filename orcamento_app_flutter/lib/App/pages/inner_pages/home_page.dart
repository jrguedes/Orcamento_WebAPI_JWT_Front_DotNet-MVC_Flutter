import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
        colors: [
          Colors.white,
          Color.fromARGB(163, 34, 13, 69),
        ],
        radius: .7,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Image(
              height: 130,
              width: 120,
              fit: BoxFit.cover,
              image: AssetImage(
                'lib/app/assets/images/2606581_5917_ouro.png',
              )),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: size.height * 0.60,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor, //Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  //style:  Theme.of(context).textTheme.headline4,
                ),
                const Text(
                  'Developed by: Júnior Guedes',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
