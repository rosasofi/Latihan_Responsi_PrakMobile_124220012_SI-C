import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/blog_detail.dart';
import 'package:latihanresponsi/blog_models.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogList();
}

class _BlogList extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Overlay dengan efek blur
          Container(
            color: Colors.black.withOpacity(0.5), // Overlay gelap
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
                  "BLOG LIST",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),
              // Daftar blog
              Expanded(
                child: _buildListBlogsBody(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListBlogsBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadBlogs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          Blog blogs = Blog.fromJson(snapshot.data);
          return _buildSuccessSection(blogs);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return const Center(
      child: Text(
        "Error loading blogs",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSuccessSection(Blog data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemBlog(data.results![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget _buildItemBlog(Results blog) {
    return Card(
      color: const Color.fromARGB(255, 123, 139, 182), // Warna Card
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetail(blog: blog),
            ),
          );
        },
        child: Row(
          children: [
            // Gambar blog
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(blog.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Konten blog
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul blog
                  Text(
                    blog.title!,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Deskripsi singkat blog
                  Text(
                    blog.summary ?? "",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
