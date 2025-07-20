import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photography/screens/home.dart';

class FullScreenImage extends StatefulWidget {
  final List<Photo> photos;
  final int index;
  final int total;

  const FullScreenImage({
    super.key,
    required this.photos,
    required this.index,
    required this.total,
  });

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.index;
  }

  void _goToPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
    if (currentIndex == 0) {
      // Optionally, you can show a message or loop back to the last image
      setState(() { currentIndex = widget.total - 1; });
    }
  }

  void _goToNext() {
    if (currentIndex < widget.total - 1) {
      setState(() {
        currentIndex++;
      });
    }
    if (currentIndex == widget.total - 1) {
      // Optionally, you can show a message or loop back to the first image
      setState(() { currentIndex = 0; });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   final photo = widget.photos[currentIndex];
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       leading: IconButton(
  //         icon: const Icon(Icons.arrow_back, color: Colors.white),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //       title: Text(
  //         'Full View',
  //         style: const TextStyle(color: Colors.white, fontSize: 16),
  //       ),
  //       centerTitle: true,
  //     ),
  //     body: Column(
  //       children: [
          
  //         Expanded(
  //           child: Stack(
  //             children: [
  //               Center(
  //                 child: PhotoView(
  //                   imageProvider: NetworkImage(photo.url),
  //                   minScale: PhotoViewComputedScale.contained,
  //                   maxScale: PhotoViewComputedScale.covered * 2,
  //                   backgroundDecoration:
  //                       const BoxDecoration(color: Colors.black),
  //                 ),
  //               ),
  //               Positioned(
  //                 left: 16,
  //                 top: 0,
  //                 bottom: 0,
  //                 child: IconButton(
  //                   icon: const Icon(Icons.arrow_back_ios,
  //                       color: Colors.white, size: 32),
  //                   onPressed: _goToPrevious,
  //                 ),
  //               ),
  //               Positioned(
  //                 right: 16,
  //                 top: 0,
  //                 bottom: 0,
  //                 child: IconButton(
  //                   icon: const Icon(Icons.arrow_forward_ios,
  //                       color: Colors.white, size: 32),
  //                   onPressed: _goToNext,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           child: Text(
  //             '${currentIndex+1}/${widget.total}',
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w500,),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photos[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black.withAlpha(1000),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Gallery View',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: PhotoView(
                    imageProvider: NetworkImage(photo.url),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.black),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 32),
                    onPressed: _goToPrevious,
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 32),
                    onPressed: _goToNext,
                  ),
                ),
              ],
            ),
          ),

          // Image timeline (thumbnails)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: widget.photos.length,
              itemBuilder: (context, index) {
                final thumb = widget.photos[index];
                final isSelected = index == currentIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                    padding: isSelected ? const EdgeInsets.all(2) : null,
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        thumb.url,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Image counter
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${currentIndex + 1}/${widget.total}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
