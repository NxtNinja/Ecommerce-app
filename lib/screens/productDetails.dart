import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  final dynamic product;

  const ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Expanded(
                  child: Image.network(
                    product['category']['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      product['title'],
                      overflow: TextOverflow.ellipsis, 
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
              child: Text(
                product['description'],
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 7.0),
              child: Text(
                'Price: \$${product['price']}', // Use product price from your JSON data
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product['images'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 5.0, bottom: 10.0),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                        child: Image.network(
                          product['images'][index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0), // Adjust padding as needed
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                    minimumSize: const Size(double.infinity, 0),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Add more details or components as needed
          ],
        ),
      ),
    );
  }
}
