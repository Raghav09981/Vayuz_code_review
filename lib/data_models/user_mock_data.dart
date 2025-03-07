class Person {
  final int id;
  final String name;
  final String imageAsset;

  Person({
    required this.id,
    required this.name,
    required this.imageAsset,
  });
}

// Mock data
List<Person> people = [
  Person(id: 1, name: 'Milly Doe', imageAsset: 'assets/svgs/john_doe.jpg'),
  Person(
    id: 2,
    name: 'Jane Smith',
    imageAsset: 'assets/svgs/jane_smith.jpg',
  ),
  Person(
    id: 3,
    name: 'Michael Brown',
    imageAsset: 'assets/svgs/michael_brown.jpg',
  ),
  Person(
    id: 4,
    name: 'Emily Davis',
    imageAsset: 'assets/svgs/emily_davis.jpg',
  ),
  Person(
    id: 5,
    name: 'Chris Wilson',
    imageAsset: 'assets/svgs/chris_wilson.jpg',
  ),
];
