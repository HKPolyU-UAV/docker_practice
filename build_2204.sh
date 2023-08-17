echo "BUILD AIRO DOCKER IMAGE"

distro="gpu-2204"
final_name="gpu-2204"

docker build \
    -f dkerfiles/Dockerfile.$distro \
    -t airo_noetic_lala:$final_name .