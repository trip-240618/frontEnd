import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/presentation/common/album/album_image.dart';
import 'package:tripStory/presentation/common/appbar/base_appbar.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/icon/round_icon.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/trip/controllers/album_controller.dart';
import 'package:tripStory/presentation/trip/models/album_state.dart';

class AlbumView extends StatelessWidget {
  final DateTime selectedDateTime;

  const AlbumView({
    super.key,
    required this.selectedDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumController>(builder: (controller) {
      final state = controller.state;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final showCameraPermissionDialogOpen = state.showCameraPermissionDialog?.consume() ?? false;

        if (showCameraPermissionDialogOpen) {
          showCameraPermissionDialog();
        }
      });

      return Scaffold(
        appBar: _AlbumAppbar(
          title: state.selectedAlbum?.name ?? "",
          selectedCount: state.selectedImageLength,
          onTitlePressed: () => onAlbumSelectPressed(
            context,
            albums: state.albums,
            onAlbumPressed: (selectAlbum) => controller.onAlbumPressed(selectAlbum),
          ),
        ),
        body: Stack(
          children: [
            GridView.builder(
              controller: controller.albumScrollController,
              physics: const ClampingScrollPhysics(),
              addAutomaticKeepAlives: false,
              cacheExtent: 5000,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                childAspectRatio: 1,
              ),
              itemCount: (state.selectedAlbum?.images.length ?? 0) + 1,
              itemBuilder: (context, index) {
                final image = index == 0 ? null : state.selectedAlbum?.images[index - 1];

                return switch (index) {
                  0 => _CameraSection(
                      onCameraPressed: () => controller.onCameraPressed(),
                    ),
                  _ => _AlbumImageSection(
                      isScroll: state.isScroll,
                      image: image,
                      isSelected: state.isImageSelected(image?.id ?? ""),
                      onImagePressed: () => controller.onImageSelectedPressed(image),
                    ),
                };
              },
            ),
            Positioned(
              bottom: 0,
              child: _AlbumBottom(
                selectedImages: state.selectedImages,
                onImageReorder: (oldIndex, newIndex) => controller.reorderSelectedImages(oldIndex, newIndex),
                onImageDeletedPressed: (index) => controller.onImageSelectedDeletePressed(index),
                onSavePressed: () => controller.onImageSavePressed(selectedDateTime),
              ),
            ),
          ],
        ),
      );
    });
  }

  void onAlbumSelectPressed(
    BuildContext context, {
    required List<Album> albums,
    required Function(Album) onAlbumPressed,
  }) {
    BaseBottomSheet.show(
      context,
      _AlbumSelectView(
        albums: albums,
        onAlbumPressed: onAlbumPressed,
      ),
      heightRatio: 0.8,
    );
  }

  void showCameraPermissionDialog() {
    CommonDialog.showConfirm(
      title: "권한을 설정해주시기 바랍니다",
      confirmText: "확인",
      onConfirm: () => openAppSettings(),
    );
  }
}

class _AlbumAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int selectedCount;
  final VoidCallback onTitlePressed;

  const _AlbumAppbar({
    required this.title,
    required this.selectedCount,
    required this.onTitlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppbar(
      color: context.color.white,
      leadingWidget: AppIconButton(
        assetPath: IconConstants.leftArrow,
        onTap: () => Get.back(),
      ),
      titleWidget: GestureDetector(
        onTap: onTitlePressed,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: context.style.headline3,
              ),
              SvgIcon(
                assetPath: IconConstants.underArrow,
              ),
            ],
          ),
        ),
      ),
      actionWidget: Text.rich(
        TextSpanHelper.toSplitText(
          text: "$selectedCount/10",
          delimiter: "/",
          firstStyle: selectedCount == 0
              ? context.style.caption1.copyWith(
                  color: context.color.gray400,
                )
              : context.style.caption1.copyWith(
                  color: context.color.gray900,
                ),
          secondStyle: context.style.caption1.copyWith(
            color: context.color.gray400,
          ),
          delimiterStyle: context.style.caption1.copyWith(
            color: context.color.gray400,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

class _CameraSection extends StatelessWidget {
  final VoidCallback onCameraPressed;

  const _CameraSection({
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCameraPressed,
      child: Container(
        width: Get.width,
        height: 128,
        decoration: BoxDecoration(
          color: context.color.gray50,
        ),
        child: SvgIcon(
          assetPath: IconConstants.camera,
        ),
      ),
    );
  }
}

class _AlbumImageSection extends StatelessWidget {
  final bool isScroll;
  final AssetEntity? image;
  final bool isSelected;
  final VoidCallback onImagePressed;

  const _AlbumImageSection({
    required this.isScroll,
    required this.image,
    required this.isSelected,
    required this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) return SizedBox();

    return GestureDetector(
      onTap: onImagePressed,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AlbumImage(
            image: image!,
            thumbnailSize: ThumbnailSize.square(isScroll ? 25 : 500),
            fit: BoxFit.cover,
          ),
          if (isSelected)
            Positioned(
              child: Container(
                color: context.color.gray900.withValues(alpha: 0.6),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: SvgIcon(
              assetPath: isSelected ? IconConstants.smallRoundCheck : IconConstants.smallRoundOff,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumBottom extends StatelessWidget {
  final List selectedImages;
  final ReorderCallback onImageReorder;
  final Function(int) onImageDeletedPressed;
  final VoidCallback onSavePressed;

  const _AlbumBottom({
    required this.selectedImages,
    required this.onImageReorder,
    required this.onImageDeletedPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: context.color.white.withValues(alpha: 0.8),
      ),
      height: selectedImages.isEmpty ? 120 : 196,
      child: selectedImages.isEmpty
          ? Center(
              child: Text(
                "사진은 최대 50장 업로드 가능합니다",
                style: context.style.body1Normal,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: Get.width,
                      height: 70,
                      child: ReorderableListView.builder(
                        itemCount: selectedImages.length,
                        scrollDirection: Axis.horizontal,
                        proxyDecorator: (child, index, animation) {
                          return Material(
                            color: Colors.transparent,
                            elevation: 0,
                            child: child,
                          );
                        },
                        onReorder: onImageReorder,
                        itemBuilder: (context, index) {
                          final image = selectedImages[index];
                          return Container(
                            key: ValueKey(image.id),
                            margin: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              width: 72,
                              height: 90,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: AlbumImage(
                                        image: image,
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => onImageDeletedPressed(index),
                                      child: RoundIcon.icon(
                                        assetPath: IconConstants.smallClear,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: Get.width,
                    child: BottomButton(
                      text: "선택완료",
                      trailingIcon: RoundIcon.number(
                        number: selectedImages.length,
                        backgroundColor: context.color.white,
                      ),
                      onTap: onSavePressed,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _AlbumSelectView extends StatelessWidget {
  final List<Album> albums;
  final Function(Album) onAlbumPressed;

  const _AlbumSelectView({
    required this.albums,
    required this.onAlbumPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 17,
        right: 17,
        top: 34,
      ),
      child: GridView.builder(
        physics: const ClampingScrollPhysics(),
        cacheExtent: 5000,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 27,
          mainAxisSpacing: 34,
          childAspectRatio: 0.713,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return GestureDetector(
            onTap: () => onAlbumPressed(album),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: context.color.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: context.color.gray400,
                                offset: Offset(0, 4),
                                blurRadius: 5.3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: AlbumImage(
                            image: album.images.first,
                            thumbnailSize: ThumbnailSize.square(700),
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  album.name,
                  style: context.style.heading2.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${album.images.length}",
                  style: context.style.label1Normal.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.color.gray700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
