import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //List<Pizza> pizzasInOrder = new List();
  List<Pizza> pizzasInOrder = [];


  void _addPizza() {
    final pizzaToppingTextField = TextEditingController();
    int _sizeSelected = 1;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
                height:300,
                child:  Column(
                  children: <Widget>[
                    Text(
                      'Toppings:',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextField(
                      controller: pizzaToppingTextField,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    DropdownButton(
                        style: Theme.of(context).textTheme.headline4,
                        value: _sizeSelected,
                        items:[
                          DropdownMenuItem(child: Text("Small"), value: 0),
                          DropdownMenuItem(child: Text("Medium"), value: 1),
                          DropdownMenuItem(child: Text("Large"), value: 2),
                          DropdownMenuItem(child: Text("X-Lareg"), value: 3)
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            _sizeSelected = value!;
                          });
                        }),
                    ElevatedButton(
                      child: Text('Add Pizza'),
                      onPressed: () {
                        print("Adding a pizza");
                        setState(() {
                          Pizza newPizza = new Pizza(_sizeSelected, pizzaToppingTextField.text);
                          pizzasInOrder.add(newPizza);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: pizzasInOrder.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              title: Text(pizzasInOrder[position].description!),
              leading: Icon(Icons.restaurant_menu),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Pizza {
  int _size;
  double? price;
  String toppings;
  String? description;

  final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];
  final PIZZA_SIZES = ["Small", "Medium", "Large", "X-Large"];

  Pizza(this._size, this.toppings){
    price = PIZZA_PRICES[_size];
    description = "temp";
    description = "${PIZZA_SIZES[_size]} $toppings Pizza";
  }

  @override
  String toString() {
    return (PIZZA_SIZES[_size] + toppings + " Pizza");
  }

// Pizza(int size, String toppings) {
//    this.size = size;
//    this.toppings = toppings;
// }

}
