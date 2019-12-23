import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context, T data, int index);
