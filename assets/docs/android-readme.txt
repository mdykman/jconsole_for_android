J from Jsoftware (www.jsoftware.com) source released under GPL version 3.

*** copyright and license

JSOFTWARE SOURCES refers to the native "C" source files used to generate libj.so as well as all files in directories system/, bin/, addons/, docs/, and test/ with the exceptions of docs/android-readme.txt (this file) and docs/gpl3.txt .

JSOFTWARE SOURCES are: Copyright 1990-2012, Jsoftware Inc.  All rights reserved.

JSOFTWARE SOURCES are: Licensed under GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See docs/gpl3.txt for GNU General Public License version 3. Additional info at http://www.gnu.org/licenses.


*** Android

This Android package was created by Michael Dykman (mdykman@gmail.com) in 2012. It is licensed under GPL3.

This package is compatible with Android versions 2.2 and up.

Many thanks to Eric Iverson and Jsoftware for providing the source code for the J7 engine as well as allowing the use of script, document and image resources to make this package.

To enable the J-specific soft keyboard which is provided with this package, you must go to Settings/Languages and Keyboards to explicitly enable JKeyboard.  Within the console app, long-pressing on the console screen will bring up a menu with the item "Input Method".  That sub-menu will allow you select the newly-enabled JKeyboard.

 ** Addons under Android

Pacman (the J package manager) is broken in this release as it depends on the system having wget available.  Even if a binary for wget was bundled or already present on Android, it would be to no avail as non-rooted apps are prohibited from executing binaries, even if they are bundled within the calling application.

As a strategy towards fixing this, two avenues suggest themselves:
  one could build an HTTP client in J using the socket library.
  one could bundle libcurl and use J to wrap calls to that.

I am opting for the latter option as it presents the highest likelihood of a stable HTTP client. I expect to bundle libcurl in a near-future release of this package.

As some compensation for this shortcoming, I have bundled all available addons from the current distribution as long as they satisfied basic compatibility criteria: 
  Any addon which depends on bundled native libraries has been eliminated from this release. Examples of these include math/lapack.ijs and math/fftw.ijs.
  Any addon which depends on GL or GTK has also been eliminated from this release. See Graphics/GL2 below.

 ** JHS
 The JHS Server may be launched from the conlse via the menu option Script/Launch JHS.

 ** Shared Libraries
 The following shared libraries which are known to be referenced by J scripts are provided by Android:
    libc.so
    libz.so
    libsqlite.so
    libexpat.so

 ** Graphics/GL2

In the present release, no graphics are implemented.  It was deemed by the author that the undertaking considerably expands the scope of the current effort.  We hope to rectify this in a future release.

GL2 is available to Android via system-provided libGLESv2.so and libEGL.so.  The former provides an embedded edition the GL2 API; the latter provides platform-native containers and surfaces upon which to draw. These are the exact same facilities provided for low-level graphics under iOS as well.

There is a project of unknown quality on github seeking to provide build files in order to build libcairo for the Android: https://github.com/anoek/android-cairo . It is hoped that this can be leveraged towards providing graphics support for J under the Android environment.

 ** Foreign 2!:[0-3] Do not work on Android as on non-unix systems. 2!:5 and 2!:6 work as expected. The utility of 2!:55 is somewhat doubtful on this platform.

 ** Tests
The is a high number of failing unit tests in this release.  It is my hope that the community can guide towards those which are most dire.
