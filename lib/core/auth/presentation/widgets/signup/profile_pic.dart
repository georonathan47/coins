import 'dart:io';

import '../widgets.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    super.key,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
    required this.imagePath,
  });

  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;
  final String imagePath;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final instance = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Get.textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
        gradient: const LinearGradient(
          colors: [TColors.accent, TColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ValueListenableBuilder(
            valueListenable: ValueNotifier(widget.imagePath),
            builder: (_, value, child) {
              if (value.isNotEmpty) {
                return CircleAvatar(
                  radius: 50,
                  foregroundImage: FileImage(File(value)),
                );
              } else {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: TColors.accent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipOval(child: const Icon(Iconsax.user)),
                );
              }
            },
          ),
          InkWell(
            onTap: widget.imageUploadBtnPress,
            child: const CircleAvatar(
              radius: 13,
              backgroundColor: TColors.accent,
              child: Icon(Icons.camera_alt, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
