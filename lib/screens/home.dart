import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:photography/screens/FullScreenImage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Add this

class Photo {
  final String url;
  final double aspectRatio;

  Photo({
    required this.url,
    required this.aspectRatio,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> photos = [];
  bool isLoading = true;
  String error = '';
  int imagesLoaded = 0; // Track the number of images loaded

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5000/photos'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          photos = jsonData.map<Photo>((data) {
            // Default aspect ratio to 1.0 since no metadata
            return Photo(
              url: 'http://127.0.0.1:5000${data['url']}',
              aspectRatio: 1.0,
            );
          }).toList();
          isLoading = false;
          imagesLoaded = 0; // Reset imagesLoaded
        });
      } else {
        setState(() {
          error = 'Error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Exception: $e';
        isLoading = false;
      });
    }
  }

  void _showFullScreenImage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(
          photos: photos,
          index: index,
          total: photos.length,
        ),
      ),
    );
  }

  void _onImageLoaded() {
    setState(() {
      imagesLoaded++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ),
        ),
      );
    }

    if (error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black.withAlpha(1000),

      appBar: AppBar(
        title: const Text("Shashvat Garg's PHOTOGRAPHY",
            style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w300)),
        centerTitle: true,
        backgroundColor: Colors.black.withAlpha(1000),
        elevation: 0,
      ),

      body: MasonryGridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 6,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemCount: photos.length,
        cacheExtent: 3000, // Cache extent for better performance
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final photo = photos[index];
          return GestureDetector(
            onTap: () => _showFullScreenImage(context, index),
            child: ImageItem(photo: photo, onLoaded: _onImageLoaded),
          );
        },
      ),
    
    );
  }
}

class ImageItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onLoaded;

  const ImageItem({super.key, required this.photo, this.onLoaded});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photo.url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          if (onLoaded != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onLoaded!();
            });
          }
          return child;
        }
        return Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          ),
        );
      },
    );
  }
}
