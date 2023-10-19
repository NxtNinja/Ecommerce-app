  import 'package:assignment_internship/screens/productDetails.dart';
  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  class MainHomePage extends StatefulWidget {
    const MainHomePage({super.key});

    @override
    State<MainHomePage> createState() => _MainHomePageState();
  }

  class _MainHomePageState extends State<MainHomePage> {
    int indexOfSelected = 0;

      List<dynamic> products = [];
      String selectedCategory = "All Products";

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    Future<void> fetchData() async {
      final response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        throw Exception("Failed to load data");
      }
    }

    final List<String> buttonTexts = [
      "All Products",
      "Furniture",
      "Clothes",
      "Others"
    ];

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: Scaffold(resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 247, 248, 247),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/man-profile.jpg"),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // SizedBox(height: 2.0),
                        Text(
                          "John Doe",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                          iconSize: 32.0,
                        ),
                        PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return const [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Menu Item 1"),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Menu Item 2"),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Menu Item 3"),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: const Color.fromARGB(255, 231, 233, 237),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search for brand",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Container(
              //   child: Image.asset("assets/girlwithphone.jpg", height: 250,),
              // ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                height: 65.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: buttonTexts.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const SizedBox(width: 18.0),
                        scrollButton(index),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft, // Align the text to the left
                    child: Text(
                      "Latest Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),    
              // Filter products based on selected category
Expanded(
  child: GridView.count(
    crossAxisCount: 2,
    children: products
        .where((product) =>
            selectedCategory == "All Products" ||
            product['category']['name'] == selectedCategory)
        .map((product) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProductDetails(product: product);
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
          },
          child: Column(
            children: [
              Hero(
                tag: 'productImage_${product['id']}', // Unique tag for each product
                child: Container(
                  height: 150, // Set a fixed height for the grid cell
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(product['category']['image']),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList(),
  ),
),




            ],
          ),
        ),
      );
    }

    Widget scrollButton(int index) {
    final bool isSelected = indexOfSelected == index;
    final Color buttonColor = isSelected ? Colors.black : Colors.white;
    final Color borderColor = isSelected ? Colors.black : Colors.grey;

    return GestureDetector(
      onTap: () {
        setState(() {
          indexOfSelected = index;
          selectedCategory = buttonTexts[index];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(width: 1.0, color: borderColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            buttonTexts[index],
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  }













