import 'package:flutter/material.dart';

const outerRadius = 18.0;

const defaultPadding = 8.0;

const gridSpacing = 16.0;

EdgeInsetsGeometry get defaultPaddingValue =>
    const EdgeInsets.all(defaultPadding);

BorderRadius innerBorderRadiusFrom(double padSize) =>
    BorderRadius.circular(outerRadius - padSize);

BorderRadius get outerBorderRadius => BorderRadius.circular(outerRadius);
BorderRadius get innerBorderRadius =>
    BorderRadius.circular(outerRadius - defaultPadding);
