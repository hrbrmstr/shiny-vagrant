# This script gets run *EVERY TIME* you do vagrant [down|halt] / vagrant up to ensure any
# package changes make it into the VM. 

# Just like before, remove this if needed
export MAKE="make -j 2"

Rscript -e 'devtools::install("/vagrant/packages/CustomSupportPkg")'

# This configuration is what points the Shiny server to the local apps/ dir
# and also redirects Shiny Server logs to the local logs/ dir
cp /vagrant/conf/shiny-server.conf /etc/shiny-server/shiny-server.conf

stop shiny-server
start shiny-server