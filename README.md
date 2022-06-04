# Docker Amiberry Redquark Build container

Requirements: 
- Docker https://www.docker.com/
- Git https://git-scm.com/

## Step by step instructions

1. Install Docker on your machine, from https://www.docker.com/
2. Clone this repository: `git clone https://github.com/midwan/docker-amiberry-redquark`
3. Move into the cloned repository: `cd docker-amiberry-redquark`
4. Build the docker image from `Dockerfile`, giving it a name: `docker build --pull --rm -f "Dockerfile" -t amiberry-redquark:latest "."`
This will: 
  - Use a Debian Buster image
  - Install the ARM cross-compiler tools and dependencies required
  - Copy freetype-config inside the container 
  - Execute `bootstrap.sh` which will download MaliFB, SDL2, SDL2-image, SDL2-ttf, and build Amiberry-Redquark.
5. Spin up a container from the image: `docker run --rm -it amiberry-redquark:latest`
6. The built `amiberry` binary will be found at `/build/redquark-amiberry-rb/amiberry`
7. To rebuild Amiberry, you can re-run `/build/bootstrap.sh` in the container.

---
**Applying any of the information contained in this repository to, or modifying THEA500 Mini in any way will render the
_THEA500 Mini WARRANTY NULL AND VOID_. The use of the program and information contained here is in no way authorised,
advised, recommended or supported by Retro Games Ltd and is merely provided in compliance with the GPLv3 licence of Amiberry.**

**RETRO GAMES LTD PROVIDES THE PROGRAM, DELIVERABLES AND INFORMATION "AS IS" AND
DISCLAIMS ANY AND ALL WARRANTIES OF ANY KIND OR NATURE, WHETHER EXPRESS OR
IMPLIED, ORAL OR WRITTEN, INCLUDING WITHOUT LIMITATION TO ANY WARRANTY THAT
THE PROGRAM, DELIVERABLES AND INFORMATION DISCLOSED ARE ERROR-FREE,
OR ARE COMPATIBLE WITH ALL HARDWARE AND SOFTWARE CONFIGURATIONS, AND ANY AND
ALL WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE AND USE OF THE PROGRAM, DELIVERABLES AND
INFORMATION DISCLOSED IS WITH YOU. SHOULD THE PROGRAM, DELIVERABLES OR INFORMATION
DISCLOSED PROVE DEFECTIVE OR CAUSE THE "THEA500 MINI" OR CONNECTED DEVICES TO OPERATE
INCORECTLY, INCLUDING BUT NOT LIMITED TO, FAILING TO POWER ON, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR OR CORRECTION.**
