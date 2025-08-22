import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int imagesLoaded = 0;
  static const String backend = "https://abcd-1234.ngrok.io";
  
  get http => null; // Track the number of images loaded

  @override
  void initState() {
    super.initState();
    fetchImages();
  }


  List<String> getWebImagePaths(int count) {
    return List.generate(
      count,
      (index) => 'images/image${index + 1}.jpg',
    );
  }

  Future<void> fetchImages() async {
    try {
      final List<String> imagePaths = getWebImagePaths(43)..shuffle(); // Number of images
      
      setState(() {
        photos = imagePaths.map<Photo>((url) {
          return Photo(
            url: url, // Web-accessible path
            aspectRatio: 1.0,
          );
        }).toList();

        isLoading = false;
        imagesLoaded = 0;
      });
    } catch (e) {
      setState(() {
        error = 'Exception: $e';
        isLoading = false;
      });
    }
  }

  Future<void> fetchImages1() async {
  try {
    final resp = await http.get(Uri.parse("$backend/photos"));
    if (resp.statusCode != 200) throw Exception("HTTP ${resp.statusCode}");
    final data = jsonDecode(resp.body);
    final List<String> urls = List<String>.from(data["photos"])..shuffle();

    setState(() {
      photos = urls.map((u) => Photo(url: u, aspectRatio: 1.0)).toList();
      isLoading = false;
      imagesLoaded = 0;
    });
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
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1).withAlpha(1000),
      appBar: AppBar(
        title: const Text("Shashvat Garg's PHOTOGRAPHY",
            style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w300)),
        
        centerTitle: true,
        backgroundColor: Colors.black.withAlpha(1000),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                isLoading = true;
                error = '';
                fetchImages1();
              });
            },
          ),
          // Gallery button
          IconButton(
            icon: const Icon(Icons.photo_album_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                    photos: photos,
                    index: 0,
                    total: photos.length,
                  ),
                ),
              );
            },
          ),
        ],
         
      ),
      
      body: MasonryGridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 6,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemCount: photos.length,
        cacheExtent: 5000, // Cache extent for better performance
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
