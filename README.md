# docker-plex

This is a Dockerfile to set up "Plex Media Server" (https://plex.tv/)

You can build from Dockerfile :

```
git clone http://github.com/vsense/docker-plex
cd docker-plex
docker build -t vsense/plex .
```

Or you can pull the image built from dockerhub :

```
docker pull vsense/plex
```

Either way, you can run the container with this instruction :

```
docker run -d -v /data-location:/data -p 32400:32400 vsense/plex
```

You can specifiy as many volumes as you want. Typically you'd mount one volume for tv series and one volume for movies.
