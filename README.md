**WARNING: This project has been abandoned because I don't have any use for it anymore. You are free to do whatever you want with it and copy its code or even use it as a basis for your own projects, even if you want to make money out of them. Since I'm only putting this online for my CV, chances are high that it won't work on first launch (haven't touched the code in over a year). Also, check the env files to make sure you have everything you need to run the project.**

## Mobile App React Native (vlc-remote-app)
The mobile app is the heart of this project. This app acts as a remote for VLC, allowing you to play, pause and seek, among other things.

![React Native remote](https://i.ibb.co/z5ftVhD/Screenshot-20220127-155842.png) ![React Native remote with buttons](https://i.ibb.co/vQRv4jb/Screenshot-20220127-155853.png) ![React Native settings](https://i.ibb.co/XLwGPLm/Screenshot-20220127-155936.png)
## Mobile App Flutter (vlc-remote-app-flutter)
The mobile app was first written in Flutter. I had to port the app to React Native because a needed feature was not available in Flutter yet. When I abandoned the project, I was in the middle of porting the app so the Flutter version is more complete. It has a playlist feature, makes it possible to browse the files on the computer and to connect to a computer by scanning a QR code.

![Flutter remote](https://i.ibb.co/37GdSdL/Screenshot-20220127-162756.png) ![Flutter remote with playlist](https://i.ibb.co/pWnyqPJ/Screenshot-20220127-162953.png) ![Flutter remote with browser](https://i.ibb.co/4fnnWLQ/Screenshot-20220127-163248.png) ![Flutter remote with movie informations](https://i.ibb.co/QcJ4Bh9/Screenshot-20220127-163301.png)
## Companion (vlc-remote-companion)
The companion app is not necessary but improves the experience by making it possible to perform actions only possible from the computer such as moving VLC to another window. It also simplifies the connection process for the mobile app by creating a connexion QR code.
![Companion](https://i.gyazo.com/42bb69b9108c9b3ef720a75947df5557.png)
## Server (vlc-remote-server)
The server parses file names and interacts with the TMDb API to obtain informations about films being played.