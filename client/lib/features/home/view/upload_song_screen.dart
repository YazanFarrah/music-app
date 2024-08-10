import 'package:client/config/asset_paths.dart';
import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/widgets/custom_app_bar.dart';
import 'package:client/core/widgets/custom_form_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:client/features/home/viewmodel/upload_song_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  final _selectedColor = SharedColors.primaryColor;

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadSongProvider = context.read<UploadSongProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "uploadSong".tr(),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              uploadSongProvider.uploadSong();
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: StyleConstants.horizontalPadding,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                uploadSongProvider.selectImage();
              },
              child: Consumer<UploadSongProvider>(
                  builder: (context, uploadSongProvider, child) {
                return uploadSongProvider.image != null
                    ? SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            uploadSongProvider.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : DottedBorder(
                        radius: Radius.circular(10.r),
                        borderType: BorderType.RRect,
                        color: Theme.of(context).colorScheme.onBackground,
                        dashPattern: const [10, 10],
                        child: SizedBox(
                          height: 150.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                AssetPaths.uploadSong,
                                width: 40.w,
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                "chooseThubmnail".tr(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                      );
              }),
            ),
            SizedBox(height: 40.h),
            Consumer<UploadSongProvider>(
                builder: (context, uploadSongProvider, child) {
              return uploadSongProvider.audio != null
                  ? AudioWave(path: uploadSongProvider.audio!.path)
                  : CustomFormField(
                      readOnly: true,
                      onTap: () {
                        uploadSongProvider.selectAudio();
                      },
                      hintText: "pickSong".tr(),
                      verticalPadding: 25.h,
                    );
            }),
            SizedBox(height: 20.h),
            CustomFormField(
              hintText: "songName".tr(),
              controller: _songNameController,
              verticalPadding: 25.h,
            ),
            SizedBox(height: 20.h),
            CustomFormField(
              hintText: "artist".tr(),
              controller: _artistNameController,
              verticalPadding: 25.h,
            ),
            SizedBox(height: 20.h),
            ColorPicker(
              selectedPickerTypeColor: Theme.of(context).primaryColor,
              pickerTypeTextStyle: Theme.of(context).textTheme.displaySmall,
              onColorChanged: (Color color) {},
              color: _selectedColor,
              pickersEnabled: const {
                ColorPickerType.wheel: true,
              },
            )
          ],
        ),
      ),
    );
  }
}
