import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/theme/appcolors.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  // Constructor to accept the character data
  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          character.name ?? 'Character Details',
          style: GoogleFonts.poppins(color: AppColors.whiteColor),
        ),
        centerTitle: true,
        elevation: 0,
        // Set the back button icon color to white
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character Image Container
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.greyLightColor,
                image: DecorationImage(
                  image: character.image != null && character.image!.isNotEmpty
                      ? NetworkImage(character.image!)
                      : AssetImage('assets/images/default_image.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: character.image == null || character.image!.isEmpty
                  ? Center(
                      child: Text(
                        '?',
                        style: TextStyle(
                          fontSize: 100,
                          color: AppColors.greyTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(height: 20),
            
            // Character Info Container
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyLightColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Section with an Icon
                  _buildInfoRow(
                    'Name',
                    character.name ?? "Unknown",
                    FontAwesomeIcons.person,
                    AppColors.primaryColor,
                  ),
                  SizedBox(height: 10),
                  // Species Section with an Icon
                  _buildInfoRow(
                    'Species',
                    character.species ?? "Unknown",
                    FontAwesomeIcons.leaf,
                    AppColors.blueColor,
                  ),
                  SizedBox(height: 10),
                  // Gender Section with an Icon
                  _buildInfoRow(
                    'Gender',
                    character.gender ?? "Unknown",
                    FontAwesomeIcons.genderless,
                    AppColors.lightBlueColor,
                  ),
                  SizedBox(height: 10),
                  // House Section with an Icon
                  _buildInfoRow(
                    'House',
                    character.house ?? "Unknown",
                    FontAwesomeIcons.home,
                    AppColors.primaryLightColor,
                  ),
                  SizedBox(height: 10),
                  // Date of Birth Section with an Icon
                  _buildInfoRow(
                    'Date of Birth',
                    character.dateOfBirth ?? "Unknown",
                    FontAwesomeIcons.atlassian,
                    AppColors.blueColor,
                  ),
                  SizedBox(height: 10),
                  // Ancestry Section with an Icon
                  _buildInfoRow(
                    'Ancestry',
                    character.ancestry ?? "Unknown",
                    FontAwesomeIcons.calendar,
                    AppColors.primaryColor,
                  ),
                  SizedBox(height: 10),
                  // Patronus Section with an Icon
                  _buildInfoRow(
                    'Patronus',
                    character.patronus ?? "Unknown",
                    FontAwesomeIcons.unlock,
                    AppColors.lightBlueColor,
                  ),
                  SizedBox(height: 10),
                  // Alive Section with an Icon
                  _buildInfoRow(
                    'Alive',
                    character.alive == true ? "Yes" : "No",
                    FontAwesomeIcons.a,
                    character.alive == true ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the character info rows
  Widget _buildInfoRow(String title, String value, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        SizedBox(width: 10),
        Text(
          '$title: $value',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.blackTextColor),
        ),
      ],
    );
  }
}
