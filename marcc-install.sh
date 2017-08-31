# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "########################################################################"
echo "# MARCC, a SLURM cluster, github.com/ahundt/robotics_setup installation"
echo "########################################################################"
echo "# MANUAL STEPS REQUIRED! visit github.com/ahundt/robotics_setup for extra details"
echo "# add this to your .bashrc:"
echo "#     source .robotics_setup"
echo "#"
echo "# Install Provided by:"
echo "#     github.com/ahundt/robotics_setup"
echo "#     also see marcc-config.sh"
echo "#"
echo "# About MARCC:"
echo "#     https://www.marcc.jhu.edu/"
echo "#"
echo "# About the SLURM workload manager for clusters:"
echo "#     https://slurm.schedmd.com/"
echo "#"
echo "# MARCC tutorials:"
echo "# http://www.marcc.jhu.edu/training/intro-sessions/"
echo "# Click on `Introduction to MARCC` and `Basic Linux` for pdfs"
echo "#"
echo "# Create your own modules:"
echo "# https://www.marcc.jhu.edu/getting-started/local-python-packages/"
echo "#"
echo "# to see list of possible modules run:"
echo "# module avail"


echo "###############################################"
echo "# SLURM Cluster Manager Tensorflow Setup"
echo "###############################################"
echo "# Reference materials:"
echo "# http://killianlevacher.github.io/blog/posts/post-2016-07-22/post.html"
echo "# https://github.com/taylorpaul/ShowAndTell-SLURM"
echo "# http://stackoverflow.com/questions/34826736/running-tensorflow-on-a-slurm-cluster"
echo "# https://github.com/jakeret/tf_unet"
echo "# https://github.com/Ottunger/tensorslurm"
echo "# http://slurm.ttic.edu/"
echo "# "
echo "# Example install script:"
echo "# https://gist.github.com/taylorpaul/3e4e405ffad1be8355bf742fa24b41f0"
echo "# "
echo "# Install script companion repository:"
echo "# https://github.com/taylorpaul/ShowAndTell-SLURM"
echo "# "
echo "# TensorBoard:"
echo "# https://gist.github.com/taylorpaul/250ee3ed2524e8c28ee7c58ed656a5b9"
echo "# "
echo "# Nice SLURM python class:"
echo "# https://github.com/jhollowayj/tensorflow_slurm_manager"

# MARCC WITH ZSH: put this in your .bashrc
# module load zsh
# #source ~/.robotics_setup
# export SHELL=`which zsh`
# [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l

##################################
# Command Line Environment Config
##################################

source $DIR/marcc-config.sh

# save the set of modules to enable reloading in the future
#module save robotics_setup_modules

mkdir -p $HOME/src
mkdir -p $HOME/bin
mkdir -p $HOME/lib

cd ~/src/
if [ ! -d ~/src/robotics_setup ]; then
	git clone --recursive https://github.com/ahundt/robotics_setup.git
fi

cd robotics_setup

# ./autoenv.sh
# ./textmate.sh

mkdir -p $HOME/work/datasets

if [ ! -d $HOME/datasets ]; then
  ln -s $HOME/work/datasets $HOME/datasets
fi

# if [ ! -f $HOME/src/.env ]; then
#   ln -s .autoenv $HOME/src/.env
# fi

./zsh.sh
# byobu now loaded as a module
#./byobu-source.sh

# byobu terminal session manager: http://byobu.co/about.html
#https://launchpad.net/byobu/trunk/5.115/+download/byobu_5.115.orig.tar.gz

##################################
# Python and tensorflow utilities
##################################

./py_tools.sh
./tensorflow_slurm_manager.sh
./tensorpack.sh
./tensorlayer.sh
./sacred.sh
./tf-image-segmentation.sh
./keras.sh



cd $DIR
