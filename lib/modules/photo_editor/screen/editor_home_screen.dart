import 'package:flutter/material.dart';
import '../../../utils/extensions/logger_extension.dart';

extension ThemeExtension on BuildContext {
  Color get backgroundColor => Theme.of(this).colorScheme.background;
}

extension Window on BuildContext {
  Size get getSize => MediaQuery.of(this).size;
  double get height => getSize.height;
  double get width => getSize.width;
}

class EditorHomeScreen extends StatefulWidget {
  const EditorHomeScreen({super.key});

  @override
  State<EditorHomeScreen> createState() => _EditorHomeScreenState();
}

class _EditorHomeScreenState extends State<EditorHomeScreen> {
  // late final CanvasModel _canvasModel;

  @override
  void initState() {
    super.initState();

    // _canvasModel = CanvasModel(width: context.width, height: context.height);
  }

  final artboardObjects = <ObjectModel>[];

  void addText(String text) {
    final obj = ObjectModel(
      obj: Text(text),
    );
    artboardObjects.add(obj);
    setState(() {});
  }

  Offset start = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Stack(
            children: [
              GestureDetector(
                onPanUpdate: (v) {
                  v.globalPosition.log('Virak');
                  // setState(() {
                  //   artboardObjects[e.key].offset = v.localPosition;
                  // });
                },
                child: Container(
                  width: context.width,
                  height: context.width,
                  color: Colors.white,
                ),
              ),
              ...artboardObjects.asMap().entries.map(
                    (e) => Positioned(
                      top: e.value.offset.dy,
                      left: e.value.offset.dx,
                      child: GestureDetector(
                        onPanStart: (v) {
                          start = v.localPosition;
                        },
                        onPanUpdate: (v) {
                          // v.globalPosition.log('Virak');

                          final left = v.globalPosition.dx - start.dx;
                          final top = v.globalPosition.dy - start.dy - 260;
                          setState(() {
                            artboardObjects[e.key].offset = Offset(left, top);
                          });
                        },
                        child: e.value.obj,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomTools(
        addText: () {
          addText('Virak');
        },
      ),
    );
  }
}

class Artboard extends StatelessWidget {
  const Artboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BottomTools extends StatelessWidget {
  final GestureTapCallback addText;
  const BottomTools({
    super.key,
    required this.addText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: addText,
            icon: const Icon(
              Icons.text_fields_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class CanvasModel {
  final double width;
  final double height;
  final Color color;
  CanvasModel({
    required this.width,
    required this.height,
    this.color = Colors.white,
  });
}

class ObjectModel {
  Offset offset;
  Widget obj;
  ObjectModel({
    this.offset = Offset.zero,
    required this.obj,
  });
}
