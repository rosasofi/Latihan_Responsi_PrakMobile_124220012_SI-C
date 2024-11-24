import 'package:flutter/material.dart';
import 'dart:ui'; // Dibutuhkan untuk efek blur
import 'package:latihanresponsi/blog_models.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetail extends StatelessWidget {
  final Results blog;
  const BlogDetail({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dengan gambar
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/blog_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay dengan efek blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Overlay semi-transparan
            ),
          ),
          // Konten utama
          Column(
            children: [
              // AppBar
              AppBar(
                backgroundColor: Colors.transparent, // Transparan
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  "BLOG DETAIL",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),
              // Konten blog
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar blog
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          blog.imageUrl ?? '',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Judul blog
                      Text(
                        blog.title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Ringkasan blog
                      Text(
                        blog.summary ?? '',
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
          _launchURL(blog.imageUrl ?? '');
        },
        backgroundColor: const Color.fromARGB(255, 102, 134, 230),
        icon: const Icon(Icons.image_search_outlined),
        label: const Text("See More"),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
