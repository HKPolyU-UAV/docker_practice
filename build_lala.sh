echo "BUILD AIRO DOCKER IMAGE"

distro="swift"

for (( i=1; i<=$#; i++));
do
  param="${!i}"
  
  if [ "$param" == "--swift" ]; then
    distro="swift"
  elif [ "$param" == "--raw" ]; then
    distro="raw"
  else
    distro=${param:2:${#param}}
  fi

done

echo "BUILDING $distro DOCKER IMAGE."

docker build \
    -f Dockerfile.$distro \
    -t airo_noetic_lala:$distro .