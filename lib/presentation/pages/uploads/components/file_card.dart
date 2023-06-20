import 'imports.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {Key? key,
      required this.heading,
      required this.body,
      this.bottomWidget,
      required this.border})
      : super(key: key);

  final Widget heading;
  final Widget body;
  final Widget? bottomWidget;
  final BoxBorder border;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 7,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              Column(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: border,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: heading,
                ),
              ]),
              Expanded(
                child: body,
              ),
              bottomWidget ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
