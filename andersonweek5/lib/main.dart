import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anderson Week 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Anderson Week 5'),
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
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;

  List<Customer> customers = [
    Customer('Jimothy', 'Lorem', 1, 'Saver'),
    Customer('Timothy', 'Ipsum', 2, 'Spender'),
    Customer('Johnathy', 'Dolor', 3, 'Occasional'),
    Customer('Tomathy', 'Sit', 4, 'Frequent'),
    Customer('Ronathan', 'Amet', 5, 'Saver'),
    Customer('Jimathan', 'Consectetuer', 6, 'Spender'),
    Customer('Timathan', 'Adipiscing', 7, 'Saver'),
    Customer('Jeremy', 'Elit', 8, 'Saver'),
    Customer('Teremy', 'Sed', 9, 'Frequent'),
    Customer('Beremy', 'Diam', 10, 'Spender'),
  ];

  void _handleButtonPress() {
    setState(() {
      isLoadingItemsFromDatabase = true;
      pageFirstLoad = false;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  void _reloadPage() {
    setState(() {
      isLoadingItemsFromDatabase = false;
      pageFirstLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad 
          ? ElevatedButton(
            onPressed: _handleButtonPress,
            child: const Text("Load items from database"),
          )
        : isLoadingItemsFromDatabase ? const Column(mainAxisAlignment: MainAxisAlignment.start, 
          children: <Widget>[CircularProgressIndicator(), Text("Please Wait")],)
        : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: customers.map((cust) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cust.FirstName),
                    Text(cust.LastName),
                    Text(cust.CustomerID.toString()),
                    Text(cust.Type),
                    const Divider(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: (!pageFirstLoad && !isLoadingItemsFromDatabase) ? FloatingActionButton(
        onPressed: _reloadPage,
        tooltip: 'Reload Pages',
        child: const Icon(Icons.refresh),
      ) : null,
    );
  }
}

class Customer {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Customer (this.FirstName, this.LastName, this.CustomerID, this.Type);
}