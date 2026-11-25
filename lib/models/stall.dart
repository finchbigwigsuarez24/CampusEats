
class Stall {
  final String id;
  final String name;
  final String description;
  final String managerId;
  final bool isOpen;
  final bool isActive;

  const Stall({
    required this.id,
    required this.name,
    required this.description,
    required this.managerId,
    required this.isOpen,
    required this.isActive,
  });

  factory Stall.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return Stall(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      managerId: data['managerId'] ?? '',
      isOpen: data['isOpen'] == true,
      isActive: data['isActive'] == true,
    );
  }
}
