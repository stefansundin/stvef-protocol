## Install holomatch

Download a release from one of:
- https://github.com/Daggolin/tulip-voyager
- https://github.com/zturtleman/lilium-voyager
- https://holomat.ch/

The download from `holomat.ch` includes all of the necessary files. For the other versions you need to copy over a `baseEF` directory from somewhere else.

## Install stvef-protocol

The [`stvef-protocol`](stvef-protocol) script makes some assumption regarding where the game is installed. Edit the script if the game is located elsewhere.

Install using curl:
```
sudo curl -L -o /usr/local/bin/stvef-protocol https://github.com/stefansundin/stvef-protocol/raw/master/linux/stvef-protocol
sudo chmod +x /usr/local/bin/stvef-protocol
curl -L -o stvef-protocol.desktop https://github.com/stefansundin/stvef-protocol/raw/master/linux/stvef-protocol.desktop
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
