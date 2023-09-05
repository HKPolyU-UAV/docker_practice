echo "BUILD AIRO DOCKER IMAGE"

distro="vim4"
final_name="vim4"

echo "SWIFT BUILD? y/n:"
read swift_or_no

if [ "$swift_or_no" == "y" ] || [ "$swift_or_no" == "Y" ]; then
    distro="${distro}-swift"
else
    distro="${distro}-raw"
fi

echo "BUILDING $final_name DOCKER IMAGE."

docker build \
    -f dkerfiles/Dockerfile.vim4$distro \
    -t airo_noetic_lala:$final_name .