import 'package:client/config/asset_paths.dart';
import 'package:client/config/style_constants.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/core/utils/toast_utils.dart';
import 'package:client/core/validators/general_validations.dart';
import 'package:client/core/widgets/custom_app_bar.dart';
import 'package:client/core/widgets/custom_form_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:client/features/home/viewmodel/upload_song_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UploadSongPage extends StatefulWidget {
  const UploadSongPage({super.key});

  @override
  State<UploadSongPage> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongPage> {
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  final _selectedColor = SharedColors.primaryColor;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadSongProvider = context.read<UploadSongViewModel>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "uploadSong".tr(),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              if (uploadSongProvider.image == null) {
                ToastUtils.showError(
                  context,
                  "Please upload thumbnail",
                );
                return;
              }
              if (!_formKey.currentState!.validate()) return;
              uploadSongProvider
                  .uploadSong(
                context: context,
                artistName: _artistNameController.text.trim(),
                songName: _songNameController.text.trim(),
              )
                  .then((_) {
                _artistNameController.clear();
                _songNameController.clear();
              });
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: context.watch<UploadSongViewModel>().isLoading
          ? const UploadLoaderAnimation()
          : SingleChildScrollView(
              padding: StyleConstants.horizontalPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        uploadSongProvider.selectImage();
                      },
                      child: Consumer<UploadSongViewModel>(
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                dashPattern: const [10, 10],
                                child: SizedBox(
                                  height: 150.h,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                        AssetPaths.uploadSongAnimation,
                                        width: 40.w,
                                      ),
                                      SizedBox(height: 15.h),
                                      Text(
                                        "chooseThumbnail".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ),
                    SizedBox(height: 40.h),
                    Consumer<UploadSongViewModel>(
                        builder: (context, uploadSongProvider, child) {
                      return uploadSongProvider.audio != null
                          ? AudioWave(path: uploadSongProvider.audio!.path)
                          : CustomFormField(
                              validator: (value) =>
                                  AppValidation.isNotEmpty(value, context),
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
                      validator: (value) =>
                          AppValidation.isNotEmpty(value, context),
                      hintText: "songName".tr(),
                      controller: _songNameController,
                      verticalPadding: 25.h,
                    ),
                    SizedBox(height: 20.h),
                    CustomFormField(
                      validator: (value) =>
                          AppValidation.isNotEmpty(value, context),
                      hintText: "artist".tr(),
                      controller: _artistNameController,
                      verticalPadding: 25.h,
                    ),
                    SizedBox(height: 20.h),
                    ColorPicker(
                      selectedPickerTypeColor: Theme.of(context).primaryColor,
                      pickerTypeTextStyle:
                          Theme.of(context).textTheme.displaySmall,
                      onColorChanged: (Color color) {
                        uploadSongProvider.setHexCode(rgbToHex(color));
                      },
                      color: _selectedColor,
                      pickersEnabled: const {
                        ColorPickerType.wheel: true,
                      },
                    ),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ),
    );
  }
}
