# CUSTOMIZE THIS to suit your needs
# This has some complexity to it to show some of the things you can do

apt-get install -y libmagick++-dev libudunits2-dev libgdal-dev libcairo2-dev libv8-dev libproj-dev

install2.r --error devtools tidyverse readxl shiny shinyjs \
  rmarkdown htmltools xml2 rappdirs uuid magick scales extrafont testthat

installGithub.r thomasp85/ggforce

# Install necessary fonts
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
apt-get -y install ttf-mscorefonts-installer

# Install some more fonts
mkdir /usr/share/fonts/truetype/ppt
cp /vagrant/fonts/* /usr/share/fonts/truetype/ppt
fc-cache -fv

# add them to R
Rscript -e 'extrafont::font_import(prompt=FALSE)'