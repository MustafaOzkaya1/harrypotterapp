import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harrypotterapp/core/theme/appcolors.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/services/service.dart';
import 'package:harrypotterapp/views/detailpage/character_detail_screen.dart';

// Provider to fetch characters
final characterProvider = FutureProvider<List<CharacterModel>>((ref) async {
  final service = Service();
  return service.getCharacterInfo();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the characterProvider to get the data or error state
    final characterAsyncValue = ref.watch(characterProvider);

    // Get the screen's height and width for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,  // Arka plan rengi
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Harry Potter Characters',
          style: TextStyle(color: AppColors.greyLightColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: characterAsyncValue.when(
        // If data is fetched successfully
        data: (data) {
          return SingleChildScrollView(  // Allow the screen to scroll
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable grid scrolling, allow single scroll
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2, // 2 cards on mobile, 3 on tablet
                crossAxisSpacing: 15, // Horizontal space between cards
                mainAxisSpacing: 15, // Vertical space between cards
                childAspectRatio: 0.7, // Aspect ratio of cards
              ),
              itemCount: data.length,
              shrinkWrap: true,  // Allow content to fit on the screen
              itemBuilder: (context, index) {
                final character = data[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to character detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                          character: character,  // Pass character data to detail page
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display character image or a '?' symbol if image is unavailable
                        character.image != null && character.image!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  character.image!,
                                  fit: BoxFit.cover,
                                  height: screenHeight * 0.13, // Set height dynamically based on screen height
                                  width: double.infinity,
                                ),
                              )
                            : Center(
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    fontSize: 75,
                                    color: AppColors.greyTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            character.name ?? 'No Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.blackTextColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Gender: ${character.gender ?? 'Unknown'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Species: ${character.species ?? 'Unknown'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            character.alive == true ? 'Live' : 'Dead',
                            style: TextStyle(
                              color: character.alive == true
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        // While loading data
        loading: () => Center(
          child: CircularProgressIndicator(color: AppColors.primaryLightColor),
        ),
        // If there is an error
        error: (error, stack) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 50),
                SizedBox(height: 10),
                Text(
                  'Bir hata oluştu: $error',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
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
