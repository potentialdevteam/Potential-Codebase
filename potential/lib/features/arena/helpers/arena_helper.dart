class ArenaProfile {
  final String name;
  final int age;
  final String profilePictureUrl;
  final bool soulUnlocked;

  const ArenaProfile({
    required this.name,
    required this.age,
    required this.profilePictureUrl,
    this.soulUnlocked = false,
  });
}

class ArenaDataClass {}
