import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart'
    show SpecialistController;
import 'package:service_reservation_app/presentation/specialists/components/SpecialistItem.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppTextField.dart';

class SpecialistListScreen extends GetView<SpecialistController> {
  const SpecialistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.specialists),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'sign_out') {
                controller.logout(); // Assuming you have a signOut method in your controller
              }

            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'sign_out',
                    child: Text(AppStrings.logOut),
                  ),
                ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReusableTextField(
              labelText: AppStrings.searchSpecialistHint,
              controller: controller.searchController,
              keyboardType: TextInputType.text,
              suffixIcon: const Icon(Icons.search, color: AppColors.lightText),
              onChanged: controller.filterSpecialists,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryPurple),
          );
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              '${AppStrings.error}: ${controller.errorMessage.value}',
              style: TextStyle(color: AppColors.darkText),
            ),
          );
        } else if (controller.specialistsByCategory.isEmpty &&
            controller.searchQuery.isNotEmpty) {
          return const Center(
            child: Text(
              AppStrings.noSpecialistsFoundSearch,
              textAlign: TextAlign.center,
            ),
          );
        } else if (controller.specialistsByCategory.isEmpty &&
            controller.searchQuery.isEmpty &&
            controller.specialistsByCategory.isEmpty) {
          return const Center(
            child: Text(
              AppStrings.noSpecialistsAvailable,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.specialistsByCategory.keys.length,
            itemBuilder: (context, categoryIndex) {
              final specialization =
                  controller.specialistsByCategory.keys.toList()[categoryIndex];
              final specialistsInCategory =
                  controller.specialistsByCategory[specialization]!;
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                // You might want to control this based on some state
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        specialization,
                        style: AppTextStyles.subHeading.copyWith(
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                      itemCount: specialistsInCategory.length,
                      itemBuilder: (context, index) {
                        final specialist = specialistsInCategory[index];
                        return SpecialistGridItem(specialist: specialist);
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
