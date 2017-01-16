# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# OpenCV 2 with nonfree components"
echo "############################"
echo " Ubuntu 14.04"
cd ~/src


sudo add-apt-repository --yes ppa:xqms/opencv-nonfree
sudo apt-get update 
sudo apt-get install libopencv-nonfree-dev


cd $DIR
