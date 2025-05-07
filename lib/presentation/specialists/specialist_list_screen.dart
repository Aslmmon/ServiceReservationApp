import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart'
    show SpecialistController;
import 'package:service_reservation_app/utils/components/AppTextField.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import 'components/SpecialistItem.dart';
import 'components/empty_state.dart';
import 'components/error_message.dart';
import 'components/loading_indicator.dart'; // Added for reusable empty state

class SpecialistListScreen extends GetView<SpecialistController> {
  const SpecialistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text(AppStrings.specialists.tr),
        actions: [
          PopupMenuButton<String>(
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'sign_out',
                    onTap: () => controller.logout(),
                    child: Text(AppStrings.logOut.tr),
                  ),
                ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReusableTextField(
              // Using the reusable component
              labelText: AppStrings.searchSpecialistHint.tr,
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
          return const Center(
            child: LoadingIndicator(), // Using the reusable loading indicator
          );
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: ErrorMessage(
              message:
                  '${AppStrings.error.tr}: ${controller.errorMessage.value}',
            ), // Reusable error
          );
        } else if (controller.specialistsByCategory.isEmpty &&
            controller.searchQuery.isNotEmpty) {
          return const Center(
            child: EmptyState(
              message: AppStrings.noSpecialistsFoundSearch,
            ), // Reusable empty state
          );
        } else if (controller.specialistsByCategory.isEmpty &&
            controller.searchQuery.isEmpty) {
          return const Center(
            child: EmptyState(
              message: AppStrings.noSpecialistsAvailable,
            ), // Reusable empty state
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        specialization.tr,
                        // Assuming specialization might be localizable
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
