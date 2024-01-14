# docker-hlds-won2
A docker image that automates setting up a 1.1.0.4 Half-Life dedicated server, using the WON2 protocol, required to play various betas and releases of Counter-Strike.

### Other projects related to WON2 HLDS...
- If you want to host a server for **Counter-Strike 1.5** and various pre-Steam mods, you should [check this repository instead](https://github.com/Ch0wW/docker-hlds-won2).

# Requirements
- Docker
- docker-compose

### Features
* Creates a barebones HLDS Environment using Debian 12 (i386), using vanilla files and security patches only.
* Server settings can be configured without the requirement of rebuilding the docker image (with the exception of Half-Life 1)

### Included mods
- Counter-Strike beta 7.1
- Counter-Strike 1.0 (retail)
- Counter-Strike 1.1c (retail, patched `v1.1c`)

### Installation/Usage

Simply edit the `docker-compose.yml` to add or modify anything you require.

If you need to change the port of your server, change all occurences (= in `ports` and in the `command` sections)

**Example of Docker file**
```
version: "3.0"

services:
  hlds:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./config/cstrk10:/server/hlds_l/cstrk10
      - ./config/cstrk71:/server/hlds_l/cstrk71
      - ./config/csret11:/server/hlds_l/csret11
    ports:
      - 27015:27015
      - 27015:27015/udp
    command:
      - -port 27015 -game cstrk10 +map de_dust +maxplayers 16
```

once done, just execute `docker-compose up` to make sure everything works as intended, and you should be good to go.

### Customisation

Simply go to the `config` folder, and modify the required folders you wish.

- `config/cstrk10` is for Counter-Strike 1.0.
- `config/csret11` is for Counter-Strike 1.1. 


### Why 'csret11' instead of 'cstrk11' ?

Half-Life cannot have modfolders longer than 7 characters. Besides, from a community standpoint, `cstrk11` is an already existing folder, for CS Beta 1.1. In order to properly recognize CS v1.1 from CS Beta 1.1, I decided to rename the folder to `csret11` (short for "*CS Retail 1.1*").

-----------

This project uses files copyrighted by VALVe. 