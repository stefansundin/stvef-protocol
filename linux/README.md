## Install holomatch

Download a release from one of:
- https://github.com/Daggolin/tulip-voyager
- https://github.com/zturtleman/lilium-voyager
- https://holomat.ch/

The download from `holomat.ch` includes all of the necessary files. For the other versions you need to copy over a `baseEF` directory from somewhere else.

If you use Wine to install the Windows executable from holomat.ch, then you need to run `winetricks vcrun2015`.


## Native support

If you are using a client with native protocol handler support then you just need [`stvef.desktop`](stvef.desktop). If your favorite game client has not merged support yet then feel free to use [my test build](https://github.com/stefansundin/elite-force/releases/tag/lilium-protocol-handler-v1).

You need to modify the file to make sure it is launching the correct executable.

```shell
# Download the icon file and install it:
curl -L -o stvef.png https://github.com/stefansundin/stvef-protocol/raw/main/linux/stvef.png
xdg-icon-resource install stvef.png --size 64 --novendor

# Download the example file:
curl -L -o stvef.desktop https://github.com/stefansundin/stvef-protocol/raw/main/linux/stvef.desktop

# Modify the stvef.desktop file. You need to edit the "Exec=" path to be correct.

# Install the desktop file:
xdg-desktop-menu install stvef.desktop --novendor

# Optional clean up:
rm stvef.desktop
rm stvef.png
```

Uninstall:

```shell
xdg-desktop-menu uninstall stvef.desktop
xdg-icon-resource uninstall stvef.png
```


## Install stvef-protocol

The [`stvef-protocol`](stvef-protocol) script makes some assumptions regarding where the game is installed. Edit the script if the game is located elsewhere.

Install using curl:

```shell
sudo curl -L -o /usr/local/bin/stvef-protocol https://github.com/stefansundin/stvef-protocol/raw/main/linux/stvef-protocol
sudo chmod +x /usr/local/bin/stvef-protocol
curl -L -o stvef-protocol.desktop https://github.com/stefansundin/stvef-protocol/raw/main/linux/stvef-protocol.desktop
xdg-desktop-menu install stvef-protocol.desktop
rm stvef-protocol.desktop
```

Install by cloning repository:

```shell
git clone https://github.com/stefansundin/stvef-protocol.git
cd stvef-protocol/linux
sudo cp stvef-protocol /usr/local/bin/
xdg-desktop-menu install stvef-protocol.desktop
```

Uninstall:

```shell
xdg-desktop-menu uninstall stvef-protocol.desktop
sudo rm /usr/local/bin/stvef-protocol
```
