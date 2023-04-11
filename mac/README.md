## Install holomatch

Download a release from one of:
- https://github.com/Daggolin/tulip-voyager
- https://github.com/zturtleman/lilium-voyager
- https://www.stvef.org/cmod

Drag the `.app` to `/Applications/`. You need to copy your `baseEF` files to `$HOME/Library/Application Support/Tulip Voyager/baseEF`, `$HOME/Library/Application Support/Lilium Voyager/baseEF`, or `$HOME/Library/Application Support/STVEF/baseEF`. You can get a copy of the files from https://holomat.ch/ (download the Linux version).

Be sure to turn on `Auto Downloading` in the game settings.

Note that in Tulip Voyager, the key combination to bring up the console is <kbd>Shift + ~</kbd>.

## Install stvef-protocol

[You can download the app from the releases section.](https://github.com/stefansundin/stvef-protocol/releases/latest)

## Build stvef-protocol from source

To build and install, run:

```
git clone https://github.com/stefansundin/stvef-protocol.git
cd stvef-protocol/mac
./build.sh
cp -r stvef-protocol-app/ /Applications/stvef-protocol.app
```
