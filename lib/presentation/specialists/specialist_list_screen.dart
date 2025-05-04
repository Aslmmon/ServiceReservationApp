import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/controllers/SpecialistController.dart'
    show SpecialistController;

import '../auth/controllers/auth_controller.dart';

class SpecialistListScreen extends GetView<SpecialistController> {
  const SpecialistListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Specialists'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.filterSpecialists,
              decoration: const InputDecoration(
                labelText: 'Search by name or specialization',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        } else if (controller.filteredSpecialists.isEmpty &&
            controller.searchQuery.isNotEmpty) {
          return const Center(
            child: Text('No specialists found matching your search.'),
          );
        } else if (controller.filteredSpecialists.isEmpty &&
            controller.searchQuery.isEmpty &&
            controller.specialistsByCategory.isEmpty) {
          return const Center(child: Text('No specialists available.'));
        } else {
          return ListView.builder(
            itemCount: controller.specialistsByCategory.keys.length,
            itemBuilder: (context, categoryIndex) {
              final specialization =
                  controller.specialistsByCategory.keys.toList()[categoryIndex];
              final specialistsInCategory =
                  controller.specialistsByCategory[specialization]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      specialization,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: specialistsInCategory.length,
                    itemBuilder: (context, specialistIndex) {
                      final specialist = specialistsInCategory[specialistIndex];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: ListTile(
                          title: Text(specialist.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(specialist.specialization),
                              if (specialist.availableDays.isNotEmpty)
                                Text(
                                  'Available: ${specialist.availableDays.entries.map((e) => '${e.key} (${e.value.join(', ')})').join(', ')}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              if (specialist.bio != null &&
                                  specialist.bio!.isNotEmpty)
                                Text(
                                  specialist.bio!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                          onTap:
                              () => controller.getSpecialistDetails(
                                specialist.id,
                              ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Implement your booking logic here
                              print(
                                'Book button tapped for ${specialist.name}',
                              );
                              Get.find<AuthController>().logout(); // Access AuthController directly here

                              // Get.toNamed(
                              //   AppRoutes.booking,
                              //   arguments: specialist,
                              // );
                              // You might want to navigate to a booking screen
                              // and pass the specialist's information.
                            },
                            child: const Text('Book'),
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
