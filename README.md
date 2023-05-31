`stvef` protocol handler for https://efservers.com/.

To get this working in Firefox, you have to open `about:config`. Once there, enter `network.protocol-handler.expose.stvef` in the search field and create it as a boolean. Once created, set the value to `false`.

Based on https://github.com/stefansundin/vlc-protocol.

## Game clients with native support

After a lengthy process, I have managed to get native protocol handler support merged to the ioquake3 codebase (see: [final commit](https://github.com/ioquake/ioq3/commit/31c6d2f9d502868970ccbe62d7cef36206cbc8b1), [pull request](https://github.com/ioquake/ioq3/pull/540)). This means that eventually this repository won't be needed anymore.

It will take time for game clients to merge in support and release new versions, so your client of choice may not work out of the box just yet. Even when new clients have been released, you may still need to perform manual steps:
- Windows users will still need to register the protocol in the Windows registry (usually done by running a `.bat` file).
- macOS users will just need to drag the `.app` file to `/Applications/`.
- Linux users need to install a `.desktop` file ([see here](linux/README.md)).

If your favorite game client has not merged support yet then feel free to use [my test build](https://github.com/stefansundin/elite-force/releases/tag/lilium-protocol-handler-v1).

(The native support requires a new URL format compared to what efservers.com used in the past. LocutusOfBorg recently changed the links on efservers.com to use the new format.)
