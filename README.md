# PokeAPI (SwiftUI)

This iOS project uses MVVM as the Application architecture. For UI, we took the design from [here](https://www.figma.com/design/ZNuMRRQvD6yoOaJWRUYzk2/Pok%C3%A9dex--Community-?node-id=913-239&t=vrCYCG8zKjWgmkJP-1)

## Librarys
This project uses SPM as a tool for depedency librarys
* **Alamofire** -> Networking
* **Nuke** -> Downloading and caching images
* **Realm** -> Mobile Database
* **Wormholly** -> Network Debuging

## TODO
- [x] Add dependency librarys
- [x] Local DB
- [x] Fetch PokeAPI in Pokedex
- [ ] Search Pokemon in Pokedex
- [ ] Sort Pokemon in Pokedex
- [x] Detail Page
- [ ] Poppins Font
- [ ] Previous/next Pokemon in Detail Page
- [ ] Widget

## PokeAPI Fetching Logic
* **Home Journey**

![graph](home_logic.png)

* **Detail Journey**

![graph](detail_logic.png)

* **Fetching API Journey**

![graph](fetching_api_logic.png)

* **Searching Journey**

![graph](searching_logic.png)