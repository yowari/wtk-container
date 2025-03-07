# WTK Dev Container

Docker image for developping J2ME applications on Visual Studio Code.

# Usage

## MacOS

1. Make sure to install [XQuartz](https://www.xquartz.org/)

```
$ brew install --cask xquartz
```

2. Launch XQuartz and go to Settings -> Security and make sure "Allow connections from network clients" is on

3. Allow X11 forwarding via xhost

```
$ xhost +
```

## Launch

```
$ docker run -e DISPLAY=host.docker.internal:0 -it yowari/wtk /bin/bash
```

# Build

```
$ docker build -t yowari/wtk .
```
