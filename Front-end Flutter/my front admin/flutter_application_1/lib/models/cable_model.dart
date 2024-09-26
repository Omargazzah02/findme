class Cable {
  final String name;
  final int id;
  bool isSelected;

  Cable({
    required this.name,
    required this.id,
    this.isSelected = false,
  });

   Cable copyWith({bool? isSelected}) {
    return Cable(
      name: this.name,
      id: this.id,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
