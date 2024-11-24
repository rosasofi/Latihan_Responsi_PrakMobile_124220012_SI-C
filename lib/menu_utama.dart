import 'package:flutter/material.dart';
import 'dart:ui'; // Dibutuhkan untuk efek blur
import 'package:latihanresponsi/news_list.dart';
import 'package:latihanresponsi/blog_list.dart';
import 'package:latihanresponsi/reports_list.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  State<MenuUtama> createState() => _MenuUtama();
}

class _MenuUtama extends State<MenuUtama> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background dengan gambar
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/nasa_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Efek blur pada latar belakang
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.4), // Overlay semi-transparan
              ),
            ),
            // Konten utama
            Column(
              children: <Widget>[
                // AppBar
                AppBar(
                  backgroundColor:
                      const Color.fromARGB(0, 255, 255, 255), // Transparan
                  elevation: 0,
                  centerTitle: true,
                  title: const Text(
                    'Hai, Username!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      // Handle search query change
                    },
                  ),
                ),
                // ListView dengan Card
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      _buildMenuCard(
                        context,
                        title: "News",
                        description:
                            "Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites",
                        imagePath: 'assets/image/news.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsList()),
                          );
                        },
                      ),
                      _buildMenuCard(
                        context,
                        title: "Blog",
                        description:
                            "Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast",
                        imagePath: 'assets/image/blog.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BlogList()),
                          );
                        },
                      ),
                      _buildMenuCard(
                        context,
                        title: "Reports",
                        description:
                            "Space station and other missions often publish their data. With SNAPI, you can include it in your app as well!",
                        imagePath: 'assets/image/reports.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportsList()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Floating Action Button
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat Card Menu
  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color.fromARGB(255, 123, 139, 182),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white70,
        child: Row(
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
