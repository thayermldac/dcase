#!/bin/bash
# Author: Justice Amoh & Ben Priest
# Description: Bootstrap script for Vagrant Machine. The VM image is configured
# for the DCASE 2017 challenge (task 4).
#
# https://github.com/ankitshah009/Task-4-Large-scale-weakly-supervised-sound-event-detection-for-smart-cars/tree/2905cad2a1bad47c9837a3c55c6f477098faeca8
#
# Adapted from: bootstrap.sh by Holberton School

# Anaconda
apt-get update -q
su - vagrant

echo installing Anaconda
miniconda=Miniconda2-4.3.21-Linux-x86_64.sh
cd /vagrant
if [[ ! -f $miniconda ]]; then
    wget --quiet http://repo.continuum.io/miniconda/$miniconda
fi
chmod +x $miniconda
./$miniconda -b -p /home/vagrant/anaconda

echo 'export PATH="/home/vagrant/anaconda/bin:$PATH"' >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc
chown -R vagrant:vagrant /home/vagrant/anaconda
/home/vagrant/anaconda/bin/conda install conda-build anaconda-client anaconda-build -y -q

# Conda Installations
/home/vagrant/anaconda/bin/conda install -y numpy
/home/vagrant/anaconda/bin/conda install -y matplotlib
/home/vagrant/anaconda/bin/conda install -y pandas
/home/vagrant/anaconda/bin/conda install -y ipython
/home/vagrant/anaconda/bin/conda install -y h5py
/home/vagrant/anaconda/bin/conda install -y jupyter
/home/vagrant/anaconda/bin/conda install -y seaborn

# Tensorflow
/home/vagrant/anaconda/bin/conda config --add channels conda-forge
/home/vagrant/anaconda/bin/conda install -y tensorflow
 
# Keras
/home/vagrant/anaconda/bin/pip install keras
/home/vagrant/anaconda/bin/pip install sklearn

# dcase dependencies
sudo /home/vagrant/anaconda/bin/pip install --upgrade youtube_dl
/home/vagrant/anaconda/bin/pip install pafy
/home/vagrant/anaconda/bin/pip install tqdm

sudo apt-get -y install sox

# Ubuntu 14 LTS need expanded repository for ffmpeg
sudo add-apt-repository ppa:mc3man/trusty-media  
sudo apt-get -y update  
sudo apt-get -y install ffmpeg  
sudo apt-get -y install frei0r-plugins  