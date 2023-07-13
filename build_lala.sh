echo "BUILD AIRO DOCKER IMAGE"

distro=""
final_name=""

echo "GOT GPU? y/n:"
read got_gpu

if [ "$got_gpu" == "y" ] || [ "$got_gpu" == "Y" ]; then
    distro="${distro}gpu"
    final_name="${final_name}gpu"
else
    distro="${distro}nogpu"
    final_name="${final_name}nogpu"
fi


echo "SWIFT BUILD? y/n:"
read swift_or_no

if [ "$swift_or_no" == "y" ] || [ "$swift_or_no" == "Y" ]; then
    distro="${distro}-swift"
else
    distro="${distro}-raw"
fi


echo "WITH AIRO PACKAGES? y/n:"
read airo_pkg_or_no

if [ "$airo_pkg_or_no" == "y" ] || [ "$airo_pkg_or_no" == "Y" ]; then
    distro="${distro}-pkg"
    final_name="${final_name}-pkg"
else
    distro="${distro}-nopkg"
    final_name="${final_name}-nopkg"
fi


echo "BUILDING $final_name DOCKER IMAGE."


docker build \
    -f dkerfiles/Dockerfile.$distro \
    -t airo_noetic_lala:$final_name .