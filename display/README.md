# External display setup

## Instructions (if you already have your override file)

1. Reboot machine, hold cmd+R to enter recovery mode
2. Log in and use Disk Utility to mount Macintosh HD. Close Disk Utility.
3. Open Terminal and do the following:
```bash
cd /Volumes/Macintosh\ HD/System/Library/Displays/Contents/Resources
cp -R Overrides Overrides.bak
cp -R /Volumes/Macintosh\ HD/Users/julianlo/Downloads/DisplayVendorID-30ae Overrides/
reboot
```

## Generating new override files

See the Basic guide below on instructions on using `patch-edid.rb`. In this repo, `patch-edid-ex.rb` is an improvement for the scenario where the display has a single extension block.

## Instructions (if you have never done this before)

1. Follow [comsysto display override tool](https://comsysto.github.io/Display-Override-PropertyList-File-Parser-and-Generator-with-HiDPI-Support-For-Scaled-Resolutions/) for everything **BUT** step 4!
2. Instead of that step 4, follow the instructions at the top of this page (involving restarting in recovery mode) to copy your override file into `/System/Library/Displays/Contents/Resources/Overrides`.
3. Proceed to step 5 in comsysto's guide.

## Resources

### [God guide](https://forums.macrumors.com/threads/guide-fixing-external-monitor-scaling-and-fuzziness-issues-with-mbp-and-osx.2179968/)

Describes the winning solution.

### [RDM](https://github.com/avibrazil/RDM)

Needed to show and pick one of the newly added custom resolutions.

### [comsysto display override tool](https://comsysto.github.io/Display-Override-PropertyList-File-Parser-and-Generator-with-HiDPI-Support-For-Scaled-Resolutions/)

Helpful tool to craft overrides.

### [Basic guide](https://spin.atomicobject.com/2018/08/24/macbook-pro-external-monitor-display-problem/)

Points out the YCrCb issue. Not full enough of a solution for the Lenovo Y27q-20.

