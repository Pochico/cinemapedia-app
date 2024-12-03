class Actor {
  final int id;
  final String name;
  final String? character;
  final String profilePath;

  Actor({
    this.character,
    required this.id,
    required this.profilePath,
    required this.name,
  });
}
