The script assumes the game is installed to `$HOME/.wine/drive_c/Program Files (x86)/Raven/Star Trek Voyager Elite Force/stvoyHM.exe`. Edit `stvef-protocol` if it is located elsewhere.


Install using curl:
```
sudo curl -L -o /usr/local/bin/stvef-protocol https://github.com/stefansundin/stvef-protocol/raw/master/linux/stvef-protocol
sudo chmod +x /usr/local/bin/stvef-protocol
curl -L -o stvef-protocol.desktop https://github.com/stefansundin/stvef-protocol/raw/master/linux/stvef-protocol.desktop
xdg-desktop-menu install stvef-protocol.desktop
rm stvef-protocol.desktop
```

Alternative install by cloning repository:
```shell
git clone https://github.com/stefansundin/stvef-protocol.git
cd stvef-protocol/linux
sudo cp stvef-protocol /usr/local/bin/
xdg-desktop-menu install stvef-protocol.desktop
```
