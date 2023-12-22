import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

/// We can use this class to convert any widget to an image.
/// It works even with widgets that are not visible on the screen.
class WidgetToImages {
  /// Creates an image from the given widget.
  ///
  /// Parameters:
  /// - widget: The widget to convert into an image.
  /// - wait: Optional duration to wait before capturing the image.
  /// - logicalSize: The logical size of the widget. Defaults to the window's physical size divided by the device pixel ratio.
  /// - imageSize: The desired size of the output image. Defaults to the window's physical size.
  ///
  /// Returns:
  /// A [Uint8List] representing the image data in PNG format, or null if the conversion failed.
  static Future<Uint8List?> createImageFromWidget(
    Widget widget, {
    Duration? wait,
    Size? logicalSize,
    Size? imageSize,
  }) async {
    final repaintBoundary = RenderRepaintBoundary();
    // Calculate logicalSize and imageSize if not provided
    logicalSize ??= const Size(200, 200);
    imageSize ??= const Size(200, 200);
    // Ensure logicalSize and imageSize have the same aspect ratio
    assert(
      logicalSize.aspectRatio == imageSize.aspectRatio,
      'logicalSize and imageSize must not be the same',
    );
    // Create the render tree for capturing the widget as an image
    final renderView = RenderView(
      view: ui.PlatformDispatcher.instance.implicitView!,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1,
      ),
    );
    final pipelineOwner = PipelineOwner();
    final buildOwner = BuildOwner(focusManager: FocusManager());
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();
    // Attach the widget's render object to the render tree
    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: widget,
      ),
    ).attachToRenderTree(buildOwner);
    buildOwner.buildScope(rootElement);
    // Delay if specified
    if (wait != null) {
      await Future.delayed(wait);
    }
    // Build and finalize the render tree
    buildOwner
      ..buildScope(rootElement)
      ..finalizeTree();
    // Flush layout, compositing, and painting operations
    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();
    // Capture the image and convert it to byte data
    final image = await repaintBoundary.toImage(
      pixelRatio: imageSize.width / logicalSize.width,
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Return the image data as Uint8List
    return byteData?.buffer.asUint8List();
  }
}

class WidgetToImage {
  static Future<String> renderFlutterWidget(
    Widget widget, {
    required String fileName,
    required String folderName,
    Size logicalSize = const Size(200, 200),
    double pixelRatio = 1,
  }) async {
    /// finding the widget in the current context by the key.
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    /// create a new pipeline owner
    final PipelineOwner pipelineOwner = PipelineOwner();

    /// create a new build owner
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

    try {
      final RenderView renderView = RenderView(
        view: ui.PlatformDispatcher.instance.views.first,
        child: RenderPositionedBox(
          alignment: Alignment.center,
          child: repaintBoundary,
        ),
        configuration: ViewConfiguration(
          size: logicalSize,
          devicePixelRatio: pixelRatio,
        ),
      );

      /// setting the rootNode to the renderview of the widget
      pipelineOwner.rootNode = renderView;

      /// setting the renderView to prepareInitialFrame
      renderView.prepareInitialFrame();

      /// setting the rootElement with the widget that has to be captured
      final RenderObjectToWidgetElement<RenderBox> rootElement =
          RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      ).attachToRenderTree(buildOwner);

      ///adding the rootElement to the buildScope
      buildOwner.buildScope(rootElement);

      await Future.delayed(const Duration(seconds: 1));

      ///adding the rootElement to the buildScope
      buildOwner.buildScope(rootElement);

      /// finialize the buildOwner
      buildOwner.finalizeTree();

      ///Flush Layout
      pipelineOwner.flushLayout();

      /// Flush Compositing Bits
      pipelineOwner.flushCompositingBits();

      /// Flush paint
      pipelineOwner.flushPaint();

      final ui.Image image =
          await repaintBoundary.toImage(pixelRatio: pixelRatio);

      /// The raw image is converted to byte data.
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      try {
        final String directory = (await getApplicationSupportDirectory()).path;

        final String path = '$directory/$folderName/$fileName.png';
        final File file = File(path);
        if (!await file.exists()) {
          await file.create(recursive: true);
        }
        await file.writeAsBytes(byteData!.buffer.asUint8List());

        return path;
      } catch (e) {
        throw Exception('Failed to save screenshot to app group container: $e');
      }
    } catch (e) {
      throw Exception('Failed to render the widget: $e');
    }
  }
}
