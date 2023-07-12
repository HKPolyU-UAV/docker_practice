echo "BUILD AIRO DOCKER IMAGE"

distro=""

echo "GOT GPU? y/n:"
read got_gpu

if [ "$got_gpu" == "y" ] || [ "$got_gpu" == "Y" ]; then
    distro="${distro}gpu"
else
    distro="${distro}nogpu"
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
else
    distro="${distro}-nopkg"
fi


echo "BUILDING $distro DOCKER IMAGE."

docker build \
    -f dkerfiles/Dockerfile.$distro \
    -t airo_noetic_lala:$distro .