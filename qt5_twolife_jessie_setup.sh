#!/bin/bash

# Adventures with Qt5 and Raspbian Jessie.
# Using libraries from twolife.be

# Add the twolife.be repository.
sudo bash -c 'cat << EOF > /etc/apt/sources.list.d/twolife.list
# Raspbian Jessie (stable)
deb https://twolife.be/raspbian/ jessie main
deb-src https://twolife.be/raspbian/ jessie main
EOF'

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2578B775
sudo apt-get install apt-transport-https

sudo apt-get -y update
sudo apt-get -y dist-upgrade

# Install most of the needed Qt packages.
sudo apt-get -y install qml-module-qtquick2 qml qmlscene qml-module-qtquick-particles2

# Install the QtQuick/QML demos 
sudo apt-get -y install qtdeclarative5-examples

# Install some prerequisites for the demos
sudo apt-get -y install qml-module-qtquick-controls qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings

# We unfortunatly have to fix some libraries.
sudo mv /opt/vc/lib/libGLESv2.so /opt/vc/lib/libGLESv2.so.2
sudo mv /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1
sudo ldconfig

# Alternative method for fixing the libraries.
#sudo ln -fs /opt/vc/lib/libGLESv2.so /opt/vc/lib/libGLESv2.so.2
#sudo ln -fs /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1

#Uncomment these to add some practical environment variables to every login.
#cat << EOF >> ~/.profile
#export QT_SELECT=5
#export QT_QPA_PLATFORM=eglfs
#export LD_LIBRARY_PATH=/opt/vc/lib
#EOF

#Create a batchfile for running some demo
cat << EOF >> ~/photoviewer.sh
#!/bin/bash
export QT_SELECT=5
export QT_QPA_PLATFORM=eglfs
export LD_LIBRARY_PATH=/opt/vc/lib
qml /usr/lib/arm-linux-gnueabihf/qt5/examples/quick/demos/photoviewer/main.qml
EOF
chmod u+x photoviewer.sh

