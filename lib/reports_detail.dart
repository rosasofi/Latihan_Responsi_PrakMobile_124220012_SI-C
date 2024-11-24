import 'package:flutter/material.dart';
import 'dart:ui'; // For blur effect
import 'package:url_launcher/url_launcher.dart';
import 'package:latihanresponsi/reports_models.dart';

class ReportsDetail extends StatelessWidget {
  final Results report;
  const ReportsDetail({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with an image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/image/nasa_background.jpg'), // Update with your image asset or network image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Semi-transparent overlay
            ),
          ),
          // Main content
          Column(
            children: [
              // AppBar (transparent with white text)
              AppBar(
                backgroundColor: Colors.transparent, // Transparent background
                elevation: 0, // No shadow
                centerTitle: true,
                title: const Text(
                  "REPORTS DETAIL",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // White text
                  ),
                ),
              ),
              // Main report content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Report image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          report.imageUrl ?? '',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Report title
                      Text(
                        report.title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Report summary
                      Text(
                        report.summary ?? '',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(report.imageUrl ?? '');
        },
        backgroundColor:
            const Color.fromARGB(255, 102, 134, 230), // Blue button color
        icon: const Icon(Icons.open_in_browser),
        label: const Text("See More"),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
