container_cmd := "podman run \
    -it \
    --rm \
    -w /workspaces/zmk \
    -v ../zmk:/workspaces/zmk \
    -v .:/workspaces/zmk-config \
    -p 3000:3000 \
    zmk"

build_cmd := "west build \
    -p always \
    -b adafruit_kb2040 \
    -- \
    -DSHIELD=nibble \
    -DZMK_CONFIG=/workspaces/zmk-config/config"

build_container:
    podman build -t zmk -f ../zmk/.devcontainer/Dockerfile

enter_container:
    {{container_cmd}} /bin/bash

build:
    {{container_cmd}} /bin/bash -c "cd app && {{build_cmd}}"
