import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/reports_detail.dart';
import 'package:latihanresponsi/reports_models.dart';

class ReportsList extends StatefulWidget {
  const ReportsList({Key? key}) : super(key: key);

  @override
  State<ReportsList> createState() => _ReportsList();
}

class _ReportsList extends State<ReportsList> {
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
                  "REPORTS LIST",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),
              // Daftar laporan
              Expanded(
                child: _buildListReportsBody(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListReportsBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadReports(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          Reports reports = Reports.fromJson(snapshot.data);
          return _buildSuccessSection(reports);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return const Center(
      child: Text(
        "Error loading reports",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSuccessSection(Reports data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemReport(data.results![index]);
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

  Widget _buildItemReport(Results report) {
    return Card(
      color: const Color.fromARGB(255, 123, 139, 182), // Warna Card
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportsDetail(report: report),
          ),
        ),
        child: Row(
          children: [
            // Gambar laporan
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(report.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Konten laporan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul laporan
                  Text(
                    report.title!,
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
                  // Deskripsi singkat laporan
                  Text(
                    report.summary ?? "",
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
