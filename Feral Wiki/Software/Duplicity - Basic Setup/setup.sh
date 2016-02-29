#! /bin/bash
########################
####Define Variables####
########################
echo "Prepareing for Duplicity Install."
mkdir -p ~/bin && bash
[ ! "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
echo "Installing librsync."
wget -qO ~/librsync.tar.gz http://downloads.sourceforge.net/project/librsync/librsync/0.9.7/librsync-0.9.7.tar.gz
tar xf ~/librsync.tar.gz && cd ~/librsync-0.9.7
./configure --prefix=$HOME --with-pic && make && make install
cd && rm -rf librsync{-0.9.7,.tar.gz}
echo "Installing Duplicity"
wget -qO ~/duplicity.tar.gz https://launchpad.net/duplicity/0.6-series/0.6.24/+download/duplicity-0.6.24.tar.gz
tar xf ~/duplicity.tar.gz && cd ~/duplicity-0.6.24
python setup.py install --prefix=$HOME/.local --librsync-dir=$HOME
cd && rm -rf duplicity{-0.6.24,.tar.gz}
echo "Checking it was installed correctly."
duplicity --version
duplicity --help
##
