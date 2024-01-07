Set-Location $PSScriptRoot
docker buildx ./rm mybuilder
docker buildx create --use --name mybuilder --driver-opt network=host --buildkitd-flags '--allow-insecure-entitlement network.host'
docker buildx ls
docker buildx inspect --bootstrap
docker buildx build --platform=linux/arm64,linux/amd64,linux/arm/v7 -f dockerfile.new -t drjp81/nodered:dev --push --progress=plain