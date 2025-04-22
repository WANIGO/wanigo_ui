// lib/screens/calendar_planlist.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:wanigo_part/models/wasteplan_model.dart';
import 'package:wanigo_part/services/wasteplan_service.dart';
import 'package:wanigo_part/screens/planoption.dart';

class CalendarPlanListScreen extends StatefulWidget {
  const CalendarPlanListScreen({Key? key}) : super(key: key);

  @override
  _CalendarPlanListScreenState createState() => _CalendarPlanListScreenState();
}

class _CalendarPlanListScreenState extends State<CalendarPlanListScreen> {
  final WastePlanService _wastePlanService = WastePlanService();
  List<WastePlan> _wastePlans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWastePlans();
  }

  Future<void> _loadWastePlans() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final plans = await _wastePlanService.readWastePlans();
      setState(() {
        _wastePlans = plans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading waste plans: $e');
    }
  }

  // Delete a waste plan
  Future<void> _deletePlan(WastePlan plan) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Jadwal'),
        content: Text('Apakah Anda yakin ingin menghapus jadwal ${plan.typeDescription}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      await _wastePlanService.deleteWastePlan(plan.id);
      _loadWastePlans();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Jadwal Sampah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlanTypeScreen()),
              ).then((_) => _loadWastePlans());
            },
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _wastePlans.isEmpty 
          ? _buildEmptyState() 
          : _buildPlanList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/add_calendar1.png',
            width: 120,
            height: 120,
          ),
          const Gap(20),
          const Text(
            'Belum Ada Jadwal Sampah',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          const Text(
            'Buat jadwal pemilahan atau setoran sampah untuk memulai',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Gap(20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlanTypeScreen()),
              ).then((_) => _loadWastePlans());
            },
            child: const Text('Buat Jadwal Baru'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanList() {
    // Separate plans by type
    final pemilahSampahPlans = _wastePlans.where((plan) => plan.type == 1).toList();
    final setorSampahPlans = _wastePlans.where((plan) => plan.type == 2).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Pemilahan Sampah Section
        if (pemilahSampahPlans.isNotEmpty) ...[
          _buildPlanSection(
            title: 'Jadwal Pemilahan Sampah',
            plans: pemilahSampahPlans,
          ),
          const Gap(20),
        ],

        // Setoran Sampah Section
        if (setorSampahPlans.isNotEmpty) ...[
          _buildPlanSection(
            title: 'Jadwal Setoran Sampah',
            plans: setorSampahPlans,
          ),
        ],
      ],
    );
  }

  Widget _buildPlanSection({
    required String title,
    required List<WastePlan> plans,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        ...plans.map((plan) => _buildPlanCard(plan)).toList(),
      ],
    );
  }

  Widget _buildPlanCard(WastePlan plan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getPlanDescription(plan),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Waktu: ${plan.startingHoursDescription}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deletePlan(plan),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get plan description
  String _getPlanDescription(WastePlan plan) {
    if (plan.type == 1) {
      // Pemilahan Sampah
      return "${plan.typeDescription} - ${plan.frequencyDescription} "
             "mulai ${DateFormat('dd MMM yyyy').format(plan.startDate!)}";
    } else {
      // Setoran Sampah
      return "${plan.typeDescription} "
             "pada ${DateFormat('dd MMM yyyy').format(plan.planDate!)}";
    }
  }
}