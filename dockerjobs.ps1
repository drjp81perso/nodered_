if ($env:GITHUB_REF_NAME -eq "main") {
    $env:GITHUB_REF_NAME = "latest"
}
if ($env:GITHUB_REF_NAME -ilike "*/*") {
   exit 0
}

Set-Location $PSScriptRoot
docker buildx ./rm mybuilder
docker buildx create --use --name mybuilder --driver-opt network=host --buildkitd-flags '--allow-insecure-entitlement network.host'
docker buildx ls
docker buildx inspect --bootstrap
docker buildx build --platform=linux/arm64,linux/amd64 -f dockerfile.new -t drjp81/nodered:$env:GITHUB_REF_NAME --push --progress=plain .