**WARNING: This project has been abandoned because I don't have any use for it anymore. You are free to do whatever you want with it and copy its code or even use it as a basis for your own projects, even if you want to make money out of them. Since I'm only putting this online for my CV, chances are high that it won't work on first launch (haven't touched the code in over a year). Also, check the env files to make sure you have everything you need to run the project.**

## Mobile App React Native (vlc-remote-app)
The mobile app is the heart of this project. This app acts as a remote for VLC, allowing you to play, pause and seek, among other things.

![image](https://user-images.githubusercontent.com/19517737/151398850-8903beeb-1080-40b7-867d-84c2f458226b.png) ![image](https://user-images.githubusercontent.com/19517737/151398917-92b93f71-28ec-43d5-be29-b4de7bd8057a.png) ![image](https://user-images.githubusercontent.com/19517737/151398955-31001099-8bbf-40a9-8807-3bd422b57492.png)

## Mobile App Flutter (vlc-remote-app-flutter)
The mobile app was first written in Flutter. I had to port the app to React Native because a needed feature was not available in Flutter yet. When I abandoned the project, I was in the middle of porting the app so the Flutter version is more complete. It has a playlist feature, makes it possible to browse the files on the computer and to connect to a computer by scanning a QR code.

![image](https://user-images.githubusercontent.com/19517737/151398993-7266372b-7679-4b32-97b8-28778820184c.png) ![image](https://user-images.githubusercontent.com/19517737/151399034-49a9c9e4-3af3-4ff4-80bf-89efeb8dc7f4.png) ![image](https://user-images.githubusercontent.com/19517737/151399057-dbe28d41-3e77-4e1a-974d-50d48c29fecb.png) ![image](https://user-images.githubusercontent.com/19517737/151399092-f229a089-5453-4a05-9fff-ce46ea849ac4.png)
## Companion (vlc-remote-companion)
The companion app is not necessary but improves the experience by making it possible to perform actions only possible from the computer such as moving VLC to another window. It also simplifies the connection process for the mobile app by creating a connexion QR code.
![Companion](https://i.gyazo.com/42bb69b9108c9b3ef720a75947df5557.png)
## API (vlc-remote-api)
The API parses file names and interacts with the TMDb API to obtain informations about films being played.
