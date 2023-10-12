# Building Docker images for GovStack IM-BB X-Road Metrics

## Build images locally

Images are built on python-3.8 base image with the build_images.sh shell script.
The default tag is latest. By default, the images are only built in the local
docker registry:

```
./build_images.sh
```

## Build images with custom tag and to push images to external registry

```
./build_images.sh --registry \
   <registry base url> --tag 1.0.0
```

# Example

Publishing images into your custom registry

```
./build_images.sh \ 
  --registry my-bb-docker-registry.com/im/xroad-metrics \
  --tag 1.0.0
```

will push the following images:

```
my-bb-docker-registry.com
└── im
    └── xroad-metrics
        ├── collector
        ├── corrector
        └── init-db
```
