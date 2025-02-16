import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';
import '../logic/post_bloc.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showModalOptions() {
    showModalBottomSheet(
      backgroundColor: primaryColor,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'انتخاب از گالری',
                style: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.white,
                ),
              ),
              leading: const Icon(
                Icons.photo_sharp,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              title: const Text(
                'عکس با دوربین',
                style: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.white,
                ),
              ),
              leading: const Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitPost(BuildContext context) {
    if (_imageFile != null && _titleController.text.isNotEmpty) {
      BlocProvider.of<PostBloc>(context).add(
        SubmitPostEvent(imageFile: _imageFile!, title: _titleController.text),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('عنوان و تصویر باید وارد شوند')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            } else if (state is PostCompletedState) {
              Future.delayed(Duration.zero, () {
                setState(() {
                  _imageFile = null; // تصویر پاک می‌شود
                });
                getSnackBarWidget(context, state.message, Colors.green);
              });
            } else if (state is PostErrorState) {
              Future.delayed(Duration.zero, () {
                getSnackBarWidget(context, state.error.errorMsg!, Colors.red);
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _titleController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'irs',
                    ),
                    decoration: InputDecoration(
                      labelText: 'عنوان',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'irs',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                  InkWell(
                    onTap: _showModalOptions,
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      width: getAllWidth(context),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                        borderRadius: getBorderRadiusFunc(10),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_camera_rounded,
                            color: Colors.white,
                            size: getWidth(context, 0.2),
                          ),
                          Text(
                            'انتخاب عکس',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'irs',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Column(
                    children: [
                      _imageFile != null
                          ? Image.file(
                              _imageFile!,
                              height: 200,
                            )
                          : const Text('عکس انتخاب نشد'),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          fixedSize: Size(
                            getAllWidth(context),
                            getHeight(context, 0.05),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(5),
                          ),
                        ),
                        onPressed: () => _submitPost(context),
                        child: Text(
                          'ارسال پست',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'sahel',
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
