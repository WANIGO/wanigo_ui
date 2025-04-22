// plantype.dart
import 'package:flutter/material.dart';
import 'package:wanigo_part/essentials/app_colors.dart';
import 'package:wanigo_part/screens/wasteform.dart';

class PlanTypeScreen extends StatelessWidget {
  const PlanTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: TColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: null,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/WANIGO_logo.png',
                  width: 24,
                  height: 24,
                  color: TColors.appPrimaryColor,
                ),
                Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: TColors.appPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pilih Tipe Jadwal",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: TColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Pilih jadwal pemilahan atau pengajuan setoran\nsesuai kebutuhan Anda",
                          style: TextStyle(
                            fontSize: 14,
                            color: TColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    
                    // First option card
                    _buildOptionCard(
                      context: context,
                      title: "Jadwal Pemilahan Sampah",
                      description: "Atur jadwal pemilahan sampah agar pengumpulan lebih efisien",
                      iconPath: 'assets/icons/trash_recycle.png',
                      backgroundImage: Image.asset(
                        'assets/icons/plan_typebox.png',
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WasteSortingScheduleForm(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Second option card
                    _buildOptionCard(
                      context: context,
                      title: "Jadwal Rencana Setoran",
                      description: "Pilih tanggal ajuan setoran sampah hingga 7 hari sebelum penyetoran",
                      iconPath: 'assets/icons/box_recycle.png',
                      backgroundImage: Image.asset(
                        'assets/icons/plan_typebox.png',
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        // TODO: Navigate to deposit plan schedule screen
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Section with just the wave image
          Container(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/plan_typebg.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptionCard({
    required BuildContext context,
    required String title,
    required String description,
    String? iconPath,
    VoidCallback? onTap,
    Image? backgroundImage,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 0.75),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image
            if (backgroundImage != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: backgroundImage,
                ),
              ),
            
            // Main Row Content
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0, right: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Icon positioned on top
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: iconPath != null 
                  ? Image.asset(
                      iconPath,
                      width: 80,
                      height: 80,
                    )
                  : null
              ),
            ),
          ],
        ),
      ),
    );
  }
}