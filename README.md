# docker-hlds-won2
A docker image that automates setting up a 1.1.0.4 Half-Life dedicated server, using the WON2 protocol, required to play various betas and releases of Counter-Strike.

# Requirements
- Docker
- docker-compose

### Features
* Creates a barebones HLDS Environment using Debian 12 (i386).
* Includes Team Fortress Classic, Counter-Strike 1.0 dedicated server files in its vanilla configuration that can be configured outside the docker image.

### Installation/Usage

Simply edit the `docker-compose.yml` to add or modify anything you require.

If you need to change the port of your server, change all occurences (= in `ports` and in the `command` sections)

```
version: "3.0"

services:
  hlds:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./config/cstrk10:/server/hlds_l/cstrk10 
      - ./config/tfc:/server/hlds_l/tfc
    ports:
      - 27015:27015
      - 27015:27015/udp
    command:
      - ./hlds_run -port 27015 -game cstrike +map de_dust2 +maxplayers 16 +sv_lan 1
```

once done, just execute `docker-compose up` to make sure everything works as intended, and you should be good to go.

### Customisation

Simply go to the `config` folder, and modify the required folders you wish.

- `config/cstrk10` is for Counter-Strike 1.0.
- `config/tfc` is for Team Fortress Classic. 

-----------

This project uses files copyrighted by VALVe. 