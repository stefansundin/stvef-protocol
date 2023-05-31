## Install holomatch

Download a release from one of:
- https://github.com/Daggolin/tulip-voyager
- https://github.com/zturtleman/lilium-voyager
- https://holomat.ch/

The download from `holomat.ch` includes all of the necessary files. For the other versions you need to copy over a `baseEF` directory from somewhere else.

If you use Wine to install the Windows executable from holomat.ch, then you need to run `winetricks vcrun2015`.


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
