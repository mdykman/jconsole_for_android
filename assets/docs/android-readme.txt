J from Jsoftware (www.jsoftware.com) source released under GPL version 3.

*** copyright and license

JSOFTWARE SOURCES refers to the native "C" source files used to generate libj.so as well as all files in directories system/, bin/, addons/, and test/ with the exceptions of docs/android-readme.txt (this file) and docs/gpl3.txt .

JSOFTWARE SOURCES are: Copyright 1990-2012, Jsoftware Inc.  All rights reserved.

JSOFTWARE SOURCES are: Licensed under GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See docs/gpl3.txt for GNU General Public License version 3. Additional info at http://www.gnu.org/licenses.


*** Android

J-Console for Android 1.0.5

This package is compatible with Android versions 2.1 and up.

This package was created by Michael Dykman (mdykman@gmail.com) in 2012. It is licensed under GPL3.

Many thanks to Eric Iverson and Jsoftware for providing the source code for the J7 engine, allowing the use of script, document and image resources as well as providing full JAL integation to make this package.

Thanks to Chris Burke who suggested the current layout of the soft keyboard.

Special thanks to Bill Lam for his work in making plot and viewmat work on this platform.

 ** Introduction
 
J is an astonishingly powerful mathematical tool which should be in the hands of every thinking person. Approached interactively, the user can start with simple problems and naturally build their skills until they can solve problems of enormous complexity. It defines the highest standard of what constitutes a "Tool of Thought". (http://www.jsoftware.com/papers/tot.htm)
 
The goal of the present implementation is to make J available to the highest number of mobile users possible to promote J as a standard tool of mathematical analysis.

  - michael dykman
  - Toronto, 2012
   
 ** Usage

Android uses 'activities' to present functionality to users, treating each window as a first-class UI entitiy. Exiting the console does not close open editors.  While it is possible to make the Android J console act close all windows, the pattern is deprecated in this environment. Rather than swim upstream against the prevailing environment, we have elected to let the native environment dictate this behaviour.

Graphical viewers for viewing bitmaps, PDFs, etc. are not provided by this package.  The plot package requires a third party PDF viewer to be installed on your device just as viewmat relies on your preferred viewer for bitmap graphic files.

 ** Soft Keyboard
 
To enable the J-specific soft keyboard which is provided with this package, go to Settings/Languages and Keyboards to explicitly enable JKeyboard.  Within the console app, long-pressing on the console screen will bring up a menu with the item "Input Method".  That sub-menu will allow you select the newly-enabled JKeyboard.

 ** Pacman

Thanks to contributions by Chris Burke and Bill Lam, the J Application Library is fully integrated with this Android release.

 ** JHS

 The JHS Server may be launched from the console via the menu option Script/Launch JHS.  
 
 The default browser for Android is not very good.  I recommend:
    Firefox Mobile
    Opera Mobile (NOT Opera-Mini)   

 ** Shared Libraries
 libjregex.so is bundled with the application.
 
 The following shared libraries which are known to be referenced by J scripts are provided by Android:
    libc.so
    libz.so
    libsqlite.so
    libexpat.so

To the best of the authors knowledge, no other libraries are directly supported.

 ** Graphics/GL2

In the present release, no graphics are implemented.  It was deemed by the author that the undertaking considerably expands the scope of the current effort.  We hope to rectify this in a future release.

GL2 is available to Android via system-provided libGLESv2.so and libEGL.so.  The former provides an embedded edition the GL2 API; the latter provides platform-native containers and surfaces upon which to draw. These are the exact same facilities provided for low-level graphics under iOS as well.

There is a project of unknown quality on github seeking to provide build files in order to build libcairo for the Android: https://github.com/anoek/android-cairo . It is hoped that this can be leveraged towards providing graphics support for J under the Android environment.

