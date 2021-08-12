// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'dart:ui';

import 'screen.dart';

/// Represents a window, containing information about its size, position, and
/// properties.
class PlatformWindow {
  /// Create a new window.
  PlatformWindow(this.frame, this.scaleFactor, this.screen);

  /// The frame of the screen, in screen coordinates.
  final Rect frame;

  /// The number of pixels per screen coordinate for this screen.
  final double scaleFactor;

  /// The (or a) screen containing this window, if any.
  final Screen screen;
}
