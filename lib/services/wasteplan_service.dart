// lib/services/waste_plan_service.dart
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import '../models/wasteplan_model.dart';

class WastePlanService {
  static const String _filename = 'wasteplan.json';
  
  // Get the file path for storing waste plans - with multiple fallback options
  Future<File> get _localFile async {
    // Try different path approaches and use the first one that works
    
    // 1. First approach - relative path from current directory
    String currentDir = Directory.current.path;
    String relativePath = path.join(currentDir, '..', '..', 'database', _filename);
    
    // 2. Second approach - direct path as specified in your question
    String directPath = 'C:\\Procastinator\\WANIGO\\wanigo_part\\database\\wasteplan.json';
    
    // 3. Third approach - simplified relative path from current directory
    String simplePath = path.join(currentDir, 'database', _filename);
    
    // Print all paths for debugging
    print('Attempting to read waste plans from the following paths:');
    print('1. Relative path: $relativePath');
    print('2. Direct path: $directPath');
    print('3. Simple path: $simplePath');
    
    // Try each path and use the first one that exists
    List<String> pathsToTry = [relativePath, directPath, simplePath];
    
    for (String pathToTry in pathsToTry) {
      File file = File(pathToTry);
      
      // Create directory if it doesn't exist
      try {
        await file.parent.create(recursive: true);
      } catch (e) {
        print('Could not create directory for $pathToTry: $e');
        continue;
      }
      
      try {
        // If file doesn't exist, create an empty one
        if (!await file.exists()) {
          await file.writeAsString(json.encode({'waste_plans': []}));
          print('Created new empty file at: $pathToTry');
        }
        
        // If we get here, the file exists and is accessible
        print('Successfully using file at: $pathToTry');
        return file;
      } catch (e) {
        print('Error accessing file at $pathToTry: $e');
        // Continue to next path
      }
    }
    
    // If all paths fail, create a file in the app's temporary directory as a last resort
    try {
      final tempDir = Directory.systemTemp;
      final tempPath = path.join(tempDir.path, _filename);
      final tempFile = File(tempPath);
      
      if (!await tempFile.exists()) {
        await tempFile.writeAsString(json.encode({'waste_plans': []}));
      }
      
      print('Using temporary file at: $tempPath');
      return tempFile;
    } catch (e) {
      print('All file path attempts failed. Last error: $e');
      // Create an in-memory fallback (this will not persist, but will let the app run)
      File fallbackFile = File('');
      print('WARNING: Using non-persistent fallback, data will not be saved!');
      return fallbackFile;
    }
  }

  // Read waste plans from file
  Future<List<WastePlan>> readWastePlans() async {
    try {
      final file = await _localFile;
      
      // If we're using the fallback non-persistent file
      if (file.path.isEmpty) {
        print('Using empty fallback file - returning empty waste plans list');
        return [];
      }
      
      // Read the file
      String contents = await file.readAsString();
      print('Successfully read file content. Length: ${contents.length} characters');
      
      // Try to parse the JSON
      Map<String, dynamic> jsonMap;
      try {
        jsonMap = json.decode(contents);
        print('Successfully parsed JSON');
      } catch (e) {
        print('Error parsing JSON: $e');
        print('File content: $contents');
        return [];
      }
      
      // Convert JSON to list of WastePlan objects
      List<dynamic> plansJson = jsonMap['waste_plans'] ?? [];
      print('Found ${plansJson.length} waste plans in the file');
      
      List<WastePlan> plans = [];
      for (var planJson in plansJson) {
        try {
          plans.add(WastePlan.fromJson(planJson));
        } catch (e) {
          print('Error parsing waste plan: $e');
          print('Plan JSON: $planJson');
        }
      }
      
      return plans;
    } catch (e) {
      print('Error reading waste plans: $e');
      return [];
    }
  }

  // Create or update a waste plan
  Future<void> saveWastePlan(WastePlan plan) async {
    try {
      final file = await _localFile;
      
      // If we're using the fallback non-persistent file
      if (file.path.isEmpty) {
        print('WARNING: Cannot save waste plan - using non-persistent fallback');
        return;
      }
      
      // Read existing plans
      List<WastePlan> existingPlans = await readWastePlans();
      
      // Check if plan with same ID exists
      int existingIndex = existingPlans.indexWhere((p) => p.id == plan.id);
      
      if (existingIndex != -1) {
        // Update existing plan
        existingPlans[existingIndex] = plan;
        print('Updated existing plan with ID: ${plan.id}');
      } else {
        // Add new plan
        existingPlans.add(plan);
        print('Added new plan with ID: ${plan.id}');
      }
      
      // Convert to JSON
      Map<String, dynamic> jsonMap = {
        'waste_plans': existingPlans.map((p) => p.toJson()).toList()
      };
      
      // Write back to file
      await file.writeAsString(json.encode(jsonMap));
      print('Successfully saved ${existingPlans.length} waste plans to file');
    } catch (e) {
      print('Error saving waste plan: $e');
    }
  }

  // Delete a waste plan
  Future<void> deleteWastePlan(String id) async {
    try {
      final file = await _localFile;
      
      // If we're using the fallback non-persistent file
      if (file.path.isEmpty) {
        print('WARNING: Cannot delete waste plan - using non-persistent fallback');
        return;
      }
      
      // Read existing plans
      List<WastePlan> existingPlans = await readWastePlans();
      
      // Remove plan with matching ID
      int initialCount = existingPlans.length;
      existingPlans.removeWhere((plan) => plan.id == id);
      
      if (initialCount == existingPlans.length) {
        print('No waste plan found with ID: $id');
        return;
      }
      
      print('Deleted waste plan with ID: $id');
      
      // Convert to JSON
      Map<String, dynamic> jsonMap = {
        'waste_plans': existingPlans.map((p) => p.toJson()).toList()
      };
      
      // Write back to file
      await file.writeAsString(json.encode(jsonMap));
      print('Successfully saved updated waste plans to file after deletion');
    } catch (e) {
      print('Error deleting waste plan: $e');
    }
  }
}