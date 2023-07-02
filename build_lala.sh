echo "BUILD AIRO DOCKER IMAGE"

distro="swift"

for (( i=1; i<=$#; i++));
do
  param="${!i}"
  echo $param

  if [ "$param" == "--swift" ]; then
    distro="swift"
  fi

  if [ "$param" == "--raw" ]; then
    distro="raw"
  fi

done

echo "BUILDING $distro DOCKER IMAGE."

docker build \
    -f Dockerfile.$distro \
    -t airo_noetic_lala:$distro .