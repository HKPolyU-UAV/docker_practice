echo "BUILD AIRO DOCKER IMAGE"

distro=""
final_name=""

echo "GOT GPU? y/n:"
read got_gpu

if [ "$got_gpu" == "y" ] || [ "$got_gpu" == "Y" ]; then
    distro="${distro}gpu-mpc"
    final_name="${final_name}gpu-mpc"
else
    distro="${distro}nogpu-mpc"
    final_name="${final_name}nogpu-mpc"
fi

echo "BUILDING $final_name DOCKER IMAGE."


docker build \
    -f Dockerfile.$distro \
    -t airo_noetic_lala:$final_name .