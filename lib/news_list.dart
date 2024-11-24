import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/news_detail.dart';
import 'package:latihanresponsi/news_models.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
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
          // Efek blur pada latar belakang
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Overlay gelap
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
                  "NEWS LIST",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // Warna putih untuk teks
                  ),
                ),
              ),
              // Daftar berita
              Expanded(
                child: _buildListNewsBody(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListNewsBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadNews(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          News news = News.fromJson(snapshot.data);
          return _buildSuccessSection(news);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return const Center(
      child: Text(
        "Error loading news",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSuccessSection(News data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemNews(data.results![index]);
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

  Widget _buildItemNews(Results news) {
    return Card(
      color:
          const Color.fromARGB(255, 123, 139, 182), // Warna latar belakang Card
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetail(news: news),
            ),
          );
        },
        child: Row(
          children: [
            // Gambar berita
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(news.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Konten berita
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul berita
                  Text(
                    news.title!,
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
                  // Deskripsi singkat berita
                  Text(
                    news.summary ?? "",
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
