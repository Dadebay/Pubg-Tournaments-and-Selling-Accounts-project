import '../constants/index.dart';

class EmptyUsersCard extends StatelessWidget {
  const EmptyUsersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColorBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)), side: BorderSide(width: 1, color: Colors.black26)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey,
                child: Image.asset('assets/icons/avable2.png', fit: BoxFit.cover),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Elýeterli!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
