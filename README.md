# Docker Amiberry Redquark Build container

## Create the build container and building Amiberry

1. Build the docker image from `Dockerfile`. This will install the necessary cross-compiler tools and source, and build Amiberry.
2. Spin up a container from the image.
3. The built `amiberry` binary will be found at `/build/redquark-amiberry-rb/amiberry`
4. To rebuild Amiberry, run `/build/bootstrap.sh` in the container.

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
