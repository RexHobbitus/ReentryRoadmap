import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  String? _coverPhotoUrl; // Use a URL for the cover photo to support web
  List<String?> otherPhotos = [
    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
    'https://st.depositphotos.com/2001755/3622/i/450/depositphotos_36220949-stock-photo-beautiful-landscape.jpg',
    'https://burst.shopifycdn.com/photos/photo-of-a-cityscape-with-a-ferris-wheel.jpg?width=1000&format=pjpg&exif=0&iptc=0',
    'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png',
    'https://iso.500px.com/wp-content/uploads/2016/11/stock-photo-159533631.jpg',
    'https://st.depositphotos.com/2001755/3622/i/450/depositphotos_36220949-stock-photo-beautiful-landscape.jpg',
    'https://burst.shopifycdn.com/photos/photo-of-a-cityscape-with-a-ferris-wheel.jpg?width=1000&format=pjpg&exif=0&iptc=0',
    'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png',
    'https://iso.500px.com/wp-content/uploads/2016/11/stock-photo-159533631.jpg',
  ];
  final ImagePicker _picker = ImagePicker();
  final List<double> itemHeights = [
    200,
    300,
    230,
    250,
    400,
    240,
    250,
    200,
    300,
    200
  ];
  final List<double> itemWidths = [
    350,
    300,
    200,
    280,
    400,
    210,
    250,
    260,
    300,
    230
  ];

  // Function to pick a single image from the gallery and set it as the cover photo
  Future<void> _pickCoverPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (kIsWeb) {
            // Use the network path of the image for web
            _coverPhotoUrl = image.path;
          } else {
            // Use a file path for non-web platforms
            _coverPhotoUrl = image.path;
          }
        });
      }
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_coverPhotoUrl!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add your first photos!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              borderType: BorderType.RRect,
              dashPattern: [6, 3], // Adjust dash and gap length
              radius: Radius.circular(12),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_outlined, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'Drag and drop',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'or browse for photos',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _pickCoverPhoto,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Browse'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Photo Section
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                _coverPhotoUrl != null
                    ? (kIsWeb
                        ? Image.network(
                            _coverPhotoUrl!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(_coverPhotoUrl!),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ))
                    : Image.network(
                        'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: _pickCoverPhoto,
                    child: Text('Change Cover Photo'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Other Photos Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Other Photos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Wrapping GridView.builder in a SizedBox to give it a defined height
          MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: otherPhotos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("Photo $index tapped");
                },
                child: Container(
                  height: itemHeights[index %
                      itemHeights
                          .length], // Using modulo to avoid index out of range
                  width: itemWidths[index %
                      itemWidths
                          .length], // Using modulo to avoid index out of range
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200, // Background color for layout
                  ),
                  child: Stack(
                    fit: StackFit
                        .expand, // Ensure the stack expands to fill the container
                    children: [
                      ClipRRect(
                        child: Image.network(
                          otherPhotos[index]!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors
                                  .grey, // Placeholder color for loading errors
                              child: Center(
                                  child: Icon(Icons.error)), // Error icon
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.black),
                            onPressed: () {
                              print("Options for Photo $index");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _pickCoverPhoto,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Gap(2),
                  Text('Add New Photo'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      );
    }
  }
}
