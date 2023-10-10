import 'package:flutter/material.dart';
import 'custom/circular_reveal_animation.dart';
import '../../contributors_card.dart';

class FABMenuAnimation extends StatelessWidget {
  const FABMenuAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Demo',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const _FABMenuState(title: 'FAB Menu Animation'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _FABMenuState extends StatefulWidget {
  const _FABMenuState({required this.title});

  final String title;

  @override
  State<_FABMenuState> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_FABMenuState>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  Directions _direction = Directions.left;

  String _title = "";
  bool _expanded = false;
  late List<MenuItem> list;

  @override
  void initState() {
    super.initState();
    list = [
      MenuItem(Icons.image, "Image"),
      MenuItem(Icons.video_camera_back, "Video"),
      MenuItem(Icons.file_copy, "Document")
    ];

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  //TODO make more dynamic / custom menu builder
  List<Widget> buildFABMenuStack() {
    const int multiplier = 55;

    List<Widget> widgetList = [];
    for (var i = 0; i < list.length; i++) {
      MenuItem item = list[i];
      widgetList.add(AnimatedPositioned(
        duration: Duration(milliseconds: ((i + 1) * 300)),
        curve: Curves.linearToEaseOut,
        bottom: (_direction == Directions.top)
            ? (_expanded ? ((i + 1) * multiplier) + 10 : 5)
            : 5,
        right: (_direction == Directions.top)
            ? 5
            : (_expanded ? ((i + 1) * multiplier) + 10 : 5),
        child: IconButton(
          onPressed: () {
            setState(() {
              _title = item.title;
            });
            animationController.reset();
            animationController.forward();
            _toggleMenu();
          },
          style: enabledFilledButtonStyle(true, Theme.of(context).colorScheme),
          icon: Icon(item.icon),
        ),
      ));
    }
    widgetList.add(Positioned(
      right: 0,
      bottom: 0,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _toggleMenu,
        child: const Icon(Icons.add),
      ),
    ));
    return widgetList;
  }

  void _toggleMenu() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const ContributorsCard(
              imageUrl:
                  "https://ca.slack-edge.com/T02TLUWLZ-UD73DHXAT-a81c5d456ada-512",
              name: "Harin Trivedi",
              email: "harin.trivedi@mutualmobile.com",
            ),
            const SizedBox(height: 20),
            Text(
              "Select Direction",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            SegmentedButton<Directions>(
              segments: const <ButtonSegment<Directions>>[
                ButtonSegment<Directions>(
                    value: Directions.left, label: Text('LEFT')),
                ButtonSegment<Directions>(
                    value: Directions.top, label: Text('TOP')),
              ],
              selected: <Directions>{_direction},
              showSelectedIcon: false,
              onSelectionChanged: (Set<Directions> newSelection) {
                setState(() {
                  _direction = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 10),
            CircularRevealAnimation(
              animation: animation,
              centerOffset: const Offset(100, 100),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 200,
                height: 200,
                alignment: Alignment.center,
                child: Text(_title,
                    style: const TextStyle(color: Colors.white, fontSize: 25)),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: Stack(
        alignment: AlignmentDirectional.center,
        children: buildFABMenuStack(),
      ),
    );
  }
}

enum Directions { left, top }

class MenuItem {
  IconData icon;
  String title;

  MenuItem(this.icon, this.title);
}

enabledFilledButtonStyle(bool selected, ColorScheme colors) {
  return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant);
}
