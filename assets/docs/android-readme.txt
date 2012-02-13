J from Jsoftware (www.jsoftware.com) source released under GPL version 3.

*** copyright and license

JSOFTWARE SOURCES refers to all files in this Jsoftware release package except for file gpl3.txt.

JSOFTWARE SOURCES are: Copyright 1990-2011, Jsoftware Inc.  All rights reserved.

JSOFTWARE SOURCES are: Licensed under GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See gpl3.txt for GNU General Public License version 3. Additional info at http://www.gnu.org/licenses.


*** Android

The Android package was created by Michael Dykman (mdykman@gmail.com) and is compatible with Android versions 2.1 and up.

To enable the J-specific soft keyboard, you must open Settings/Languages and Keyboards to explicitly enable JKeyboard.  Long-pressing on the console screen will bring up a menu with the item "Input Method".  That sub-menu will allow you select the JKeyboard.

 ** Addons under Android
Pacman is broken in this release as it depends on a system having wget available.  Even if a binary for wget was present on android, it would be to no avail as non-rooted apps are prohibited from executing binaries, even if they are bundled within the calling application.

As a strategy towards fixing this, two avenues suggest themselves:
  one could build an HTTP client in J using the socket library.
  one could bundle libcurl and use J to wrap calls to that.

I am opting for the latter route (having already written far too many HTTP clients with raw sockets).  I expect to bundle libcurl in a near-future release of this package.

As some compensation for this shortcoming, I have bundled all available addons from the current distribution as long as they satisfied some compatibility criteria. 
  Any addon which depends on bundled native libraries has been eliminated from this release. Examplesof these include math/lapack.ijs and math/fftw.ijs.
  Any addons which depends on GL or GTK has also been eliminated from this release.  We hope to rectify this in a future release.

 ** Graphics/GL2
The embedded version of GL2 is avilable to Android via system-provided libGLESv2.so and libEGL.so.  The former provided the GL2 API, the latter provides platform-native containers upon which to draw. These are the exact same facilities provided for low-level graphics under iOS.

There is a project of uncertain quality on github seeking to provide build files in order to build libcairo for the android: https://github.com/anoek/android-cairo . It is hoped that this can be leveraged towards providing grphics support for J under the Android environment.
