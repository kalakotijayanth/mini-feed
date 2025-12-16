import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/helper.dart';
import '../../data/models/post_model.dart';
import '../../providers/post_providers.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  
  final captionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submitPost() async {

    if ( captionController.text.isEmpty) {
      return pleaseSelectAlert(context, 'Enter Text');
    }
    if(_selectedImage == null){
      return pleaseSelectAlert(context, 'Select Image');
    }


    await ref.read(feedNotifierProvider.notifier).createPost(
      imageFile: _selectedImage!,
      caption: captionController.text,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: appBarHeight,
        child: MyAppBar(
          title: 'Create Post',
          showBack: true,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          MyTexField(controller: captionController, width: getWidth(context), height: getHeight(context)/5, borderRadius: 10, label: 'Enter Caption',),
          const SizedBox(height: 16),

          if(_selectedImage != null)const SizedBox(height: 16),
          if(_selectedImage != null)ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage!,
              width: double.infinity,
              height: getHeight(context)/4,
              fit: BoxFit.cover,
            ),
          ),
          if(_selectedImage != null)const SizedBox(height: 16),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: _pickImage,

            child: const Text('Pick Image'),
          ),



          const SizedBox(height: 16),



          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: _submitPost,
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
