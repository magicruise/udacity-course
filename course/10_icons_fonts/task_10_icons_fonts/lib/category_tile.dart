// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'category.dart';

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
const _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A [CategoryTile] to display a [Category].
class CategoryTile extends StatelessWidget {
  final Category category;
  final ValueChanged<Category> onTap;

  /// The [CategoryTile] shows the name and color of a [Category] for unit
  /// conversions.
  ///
  /// Tapping on it brings you to the unit converter.
  const CategoryTile({
    Key key,
    @required this.category,
    @required this.onTap,
  })  : assert(category != null),
        assert(onTap != null),
        super(key: key);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: category.color['highlight'],
          splashColor: category.color['splash'],
          // We can use either the () => function() or the () { function(); }
          // syntax.
          onTap: () => onTap(category),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // There are two ways to denote a list: `[]` and `List()`.
              // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
              // You can add the type argument if you'd like, i.e. <Widget>[].
              // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  // TODO: Use an Image instead of an Icon
                  /*child: Icon(
                    category.iconLocation,
                    size: 60.0,
                  ),
                  */
                  child: Image.asset(category.iconLocation),
                ),
                // replace our placeholder material icon with our custom icons
                // whose asset location is denoted by iconLocation

                // child: category.iconLocation != null ? Image.asset(category.iconLocation) : null,

                // The flutter image widget has separate constructors based on
                // whether your path points to an asset, local file or from the Web.

                // for the unitConverter, we use the Image.asset constructor

                // You can also use the Image.file constructor
                // to pick an image from a specific file location on your device,
                // such as for a photo app.

                // If you know you’ll be using an image from the net,
                // you’d use the Image.network constructor.

                // Ways to lay out your image include the fit property and aspect ratio widget.
                // With fit, you can fit to an image’s width or height
                // or compress an image into a container of space.
                // Also use an aspect ratio widget to ensure your image remains a certain ratio.
                /*
                child: category.iconLocation != null ?
                  AspectRatio(
                    aspectRatio: 3.0,
                    child: Image.asset(category.iconLocation,
                      width: 100.0,
                      fit: BoxFit.fitWidth
                    ),
                  ) : null,
                */
                Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
