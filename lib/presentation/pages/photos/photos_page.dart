import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:gap/gap.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../bloc/photos_bloc/photos_bloc.dart';
import '../../../bloc/photos_bloc/photos_event.dart';
import '../../../bloc/photos_bloc/photos_state.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          log("${state.coverPhotoUrl} ${state.otherPhotos}");
          return (state.coverPhotoUrl == null || state.coverPhotoUrl!.isEmpty)
              ? _buildEmptyState(context)
              : _buildPhotoGallery(context, state);
        }
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add your first photos!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          DottedBorder(
            color: Colors.grey,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            dashPattern: [6, 3],
            radius: const Radius.circular(12),
            child: Container(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_outlined,
                      size: 50, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text(
                    'Drag and drop',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'or browse for photos',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<PhotosBloc>().add(PickCoverPhoto()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Browse'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGallery(BuildContext context, PhotosState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoverPhotoSection(context, state),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(
              'Other Photos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          MasonryGridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: state.otherPhotos.length,
            itemBuilder: (context, index) {
              return _buildPhotoItem(context, state.otherPhotos[index]);
            },
          ),
          _buildAddPhotoButton(context),
        ],
      ),
    );
  }

  Widget _buildCoverPhotoSection(BuildContext context, PhotosState state) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          state.coverPhotoUrl != null
              ? Image.network(
                  state.coverPhotoUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
          Positioned(
            bottom: 10,
            left: 10,
            child: ElevatedButton(
              onPressed: () => context.read<PhotosBloc>().add(PickCoverPhoto()),
              child: const Text('Change Cover Photo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(BuildContext context, String photoUrl) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photoUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey,
                child: const Center(child: Icon(Icons.error)),
              );
            },
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Delete') {
                context.read<PhotosBloc>().add(DeletePhoto(photoUrl));
              } else if (value == 'Edit') {
                context.read<PhotosBloc>().add(EditPhoto(photoUrl));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => context.read<PhotosBloc>().add(PickNewPhoto()),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              Gap(8),
              Text('Add New Photo'),
            ],
          ),
        ),
      ),
    );
  }
}
