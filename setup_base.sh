# Modeled after the Docker rocker scripts.
# The idea was to make this as generic/minimal as possible and have customizations
# in the setup_custom.sh script. It's not "there" yet but it's close.

# CHANGE THIS to slow down the script but lesson VM memory requirements
export MAKE="make -j 2"

apt-get -y update
apt-get -y upgrade

# this initial list cld prbly be trimmed down slightly

apt-get -y install \
  software-properties-common python-software-properties git \
  pandoc ghostscript imagemagick build-essential aspell aspell-en \
  libxml2-dev default-jdk default-jre libboost-all-dev libcurl4-gnutls-dev 
  libssl-dev libtiff-dev libfftw3-dev 

add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

apt-get -y update
apt-get -y install r-base r-base-dev r-cran-int64 r-recommended r-cran-rcpp r-cran-rgl r-cran-inline r-cran-littler

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.utf8
/usr/sbin/update-locale LANG=en_US.UTF-8

# You might want to you use a different mirror

echo 'options(repos=structure(c(CRAN="https://cran.rstudio.com")))' >> /etc/R/Rprofile.site
echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r

ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin
ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r
ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r
ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r

R CMD javareconf

apt-get -y install gdebi-core

install.r docopt
install.r Rcpp

# TODO: Dynamically retrieve most current version

wget --quiet https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.1.834-amd64.deb
gdebi --non-interactive shiny-server-1.5.1.834-amd64.deb
rm shiny-server-1.5.1.834-amd64.deb

apt-get autoremove