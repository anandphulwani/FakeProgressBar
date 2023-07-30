# FakeProgressBar

FakeProgressBar is a fun piece of software that displays a progress bar on your screen, making it appear as if some important process is underway. This can come in handy in various situations where you want to simulate a process or task.

![Fake Progress Bar](https://raw.githubusercontent.com/anandphulwani/FakeProgressBar/master/resources/fakeprogressbar1.png "Fake Progress Bar")

**CLICKING ON THE GEAR** on the left of the screen will show you the options. You can have it display any message you want while it's "working", even something like "Formatting Hard Drive!".

![Fake Progress Bar Options](https://raw.githubusercontent.com/anandphulwani/FakeProgressBar/master/resources/fakeprogressbar2.png "Fake Progress Bar Options")

## Release

- Download the latest [ProgressBar.exe](https://github.com/anandphulwani/FakeProgressBar/releases/latest/download/ProgressBar.exe) executable from the release section, and you are ready to use.

## Problem

When the software provided by DigitalVolcano is directly installed, it gives an error of "Component 'COMDLG32.OCX' or one of its dependencies not correctly registered: a file is missing or invalid". This is because the `comdlg32.ocx` library, which is required by the software, is not found in the system path.

## Solution

This repository provides a solution to the above problem. It includes a batch file that copies the `comdlg32.ocx` library to the respective system path and then launches the setup. This ensures that the required library is available for the software to function properly.

## Steps to reproduce to create SFX executable

1. Downlaod `FakePB_Setup.exe` or the setup file of `Fake Progress Bar` By DigitalVolcano from the internet (at the time of creating this, it was located at `https://www.digitalvolcano.co.uk/download/FakePB_Setup.exe`)
2. Download missing `comdlg32.ocx` from the internet. (at the time of creating this, it was located at `https://www.bioinformatics.org/snp-tools-excel/comdlg32.ocx`, save it as `comdlg32.ocx`)
3. Download latest 7z setup file from the internet, at the time of creating this it was `7z2301-x64.exe`, Install the exe and make sure it installs in "C:\Program Files\7-zip" as this path is used further in creating the SFX.
4. Create `Install_COMDLG32OCX.bat` (copy the content from this repo) to copy/install `comdlg32.ocx` to the `system32` folder. This step ensures that the required library is available in the system path.
5. Use the following command to create `ProgressBar.7z`:
   ```
   "C:\Program Files\7-Zip\7z.exe" a ProgressBar.7z comdlg32.ocx FakePB_Setup.exe Install_COMDLG32OCX.bat
   ```
6. Create `ProgressBar.txt` (copy the content from this repo) which will make the batch file run on execution of the final sfx archive being created.
7. Download `7-Zip Extra: 7z Library, SFXs for installers, Plugin for FareManager` from `7-Zip 9.20 (2010-11-18)` section. This will redirect to the link `https://www.7-zip.org/a/7z920_extra.7z` which will download `7z920_extra.7z` file.
8. Extract `7zS.sfx` file from `7-Zip Extra (7z920_extra.7z)` file downloaded above, and move it in the same folder.
9. Use the following command to generate the final release `ProgressBar.exe` which copies the OCX file to the system and then launches the setup, using the `7zS.sfx` extracted above and `ProgressBar.txt`, `ProgressBar.7z` created above.
   ```
   copy /b 7zS.sfx + ProgressBar.txt + ProgressBar.7z ProgressBar.exe
   ```

## Issues (Once FakeProgressBar is installed)

- Problem: You can't change the look and feel on Windows once you remove or change the FakeProgressBar.exe.manifest file, even if you reintroduce it.
- Solution: https://www.instantiations.com/vast-support/documentation/FAQ/index.html#page/FAQ/va04015.html

  > ## Q: Why can’t I change the look and feel on Windows when I remove or change the <appname>.exe.manifest file?
  > 
  > ### Problem
  > 
  > The manifest file (abt.exe.manifest) controls aspects of a VAST application’s appearance.
  > - If there is no manifest file, the old Windows (XP) look and feel appears.
  > - Beginning in VA Smalltalk 9.2.2, the manifest controls whether to be aware of high DPI.
  > - Before VA Smalltalk 9.2.2, when the product was unaware of high DPI, <appname\>.exe properties could be set to override the Windows high DPI scaling behavior. This change in properties improved the executable’s user interface appearance.
  > ### 
  >
  > 
  > The look and feel of the VAST Platform(VA Smalltalk) application is controlled by a manifest file that has the same file name/ext as the runtime executable, but with a .manifest suffix (<appname>.exe.manifest). VAST Platform ships with abt.exe.manifest which does this for the development environment. The inclusion of a manifest file defers decisions about some GUI appearance elements to Windows, so basically, if the file exists, you should get the current look of the Windows level you are running on. If not, you should get the older look and feel.
  >
  > With the widespread use of high DPI, VA Smalltalk programs, some pre-9.2.2 VA Smalltalk applications did not show well on Windows 10 and later. Changing the property of the executable (<appname>.exe) Property changes are stored in the Windows registry and take precedence over the manifest (<appname>.exe.manifest) settings.
  >
  > Beginning in VAST 9.2.2, the with abt.exe.manifest shipped with VAST Platform (VA Smalltalk) causes User Interface Components to be aware of HiDPI settings in Windows.
  >
  > Some users have experienced an inconsistent ability to retain the Windows XP look and feel of their VA Smalltalk applications on newer Windows platforms such as Widows 7+. Other users have not seen HiDPI disabled (aka the VAST image is unaware of HiDPI) in their image after altering the manifest to disable HiDPI. Why is the manifest not behaving as described here?
  >
  > ### Solution
  >
  > #### Removed manifest
  >
  > If you completely removed the manifest file, or re-introduced it, the following describes the situation
  >
  > Windows caches the information related to a manifest file, and if it has done so, does not look for and read an existing manifest file again, presumably until a reboot, but that is not always the case. The work-around is to touch the .executable file (<appname>.exe) so that the modified date/time is changed. This seems to trick Windows into reading the existing manifest file again.
  >
  > Here is a link to a free open source touch application that runs on Windows:
  > 
  > [http://sourceforge.net/projects/touchforwindows/](http://sourceforge.net/projects/touchforwindows/)
  > 
  > There is a set of utilities at the following link that can help you diagnose this issue. In particular, the ManifestUtils\\TraceManifestLoading.cmd app can be used to verify when a manifest file is loaded and when it is not:
  > 
  > [http://csi-windows.com/toolkit/manifestutils](http://csi-windows.com/toolkit/manifestutils)
  > 
  > #### Altered manifest
  > 
  > If you edit the manifest (e.g. abt.exe) file to turn on/off then. The best workaround is just change the creation date of the .exe (e.g. abt.exe) which makes Windows believe it's new, and therefore invalidates the cache and causes Windows to read the abt.exe.manifest file.
  > 
  > One way to do this is to open a command window and execute e.g. copy /b abt.exe +,, or whatever your executable is named. This touches the file with the current date and time.
  > 
  > To recache a manifest file, see [http://csi-windows.com/blog/all/27-csi-news-general/245-find-out-why-your-external-manifest-is-being-ignored](http://csi-windows.com/blog/all/27-csi-news-general/245-find-out-why-your-external-manifest-is-being-ignored) [^1]
  > 
  > #### Altered registry
  > 
  > If the properties of your <appname\>.exe. have been customized, those properties (recorded in the Windows Registry) take precedence over the settings in <appname\>.exe.manifest.
  > 
  > The property is settable on Windows 10. To the pertinent properties in abt.exe, open the Properties and click on the Compatibility tab. Clock on “Change high DPI settings” button to open a dialog . Notice the “Override high DPI scaling behavior. Scaling performing by:” check box. In order to work properly, this should be
  > 
  > - unchecked or
  > - checked and have a dropdown with "Application" selected.
  >   
  > [^1]: This url doesn't work anymore, a cached copy is [here](http://htmlpreview.github.io/?https://github.com/anandphulwani/FakeProgressBar/master/resources/manifest-related/Find%20Out%20Why%20Your%20External%20Manifest%20is%20Being%20Ignored.html) and related files are [here](https://github.com/anandphulwani/FakeProgressBar/tree/master/resources/manifest-related).