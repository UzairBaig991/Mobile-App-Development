import '../models/item_model.dart';

class ApiService {
  // Simulated API fetch returning mock items
  Future<List<ItemModel>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      ItemModel(id: '1', title: 'Project Structure', description: 'Clean architecture and folder organization in Flutter.'),
      ItemModel(id: '2', title: 'Assets & Resources', description: 'Managing images, fonts, and local data files.'),
      ItemModel(id: '3', title: 'State & Navigation', description: 'Building scalable widgets and navigation flows.'),
    ];
  }
}
