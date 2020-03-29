#preparing a worker cloud for picture day!

#gotta do this to kick off proceedings. things change fast in apt land
sudo apt-get update

#R time to begin!
#add appropriate R PPA thingy for us to grab R from
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt-get update

#install R, and various useful things
sudo apt-get -y install r-base build-essential xorg-dev libreadline-dev libc6-dev zlib1g-dev libbz2-dev liblzma-dev libcurl4-openssl-dev libcairo2-dev libpango1.0-dev tcl-dev tk-dev openjdk-8-jdk openjdk-8-jre gfortran
sudo apt install build-essential python-dev libxml2 libxml2-dev zlib1g-dev
#install some R packages
sudo R -e 'install.packages("BiocManager"); BiocManager::install(c("edgeR","DESeq2","BiocParallel","scater","scran","SC3","monocle","destiny","pcaMethods","zinbwave","GenomicAlignments","RSAMtools","M3Drop","DropletUtils","switchde","biomaRt"))'
sudo R -e 'install.packages(c("tidyverse","devtools","Seurat","vcfR","igraph","car","ggpubr","rJava"))'

#many things of general utility
sudo apt-get -y install samtools bcftools bedtools htop parallel sshfs

#rclone is pretty good for google drive communication
curl https://rclone.org/install.sh | sudo bash

#python package time! start with pip
sudo apt-get -y install python3-pip
#numpy/Cython need to be installed separately before everything else because otherwise GPy/velocyto get sad
sudo apt-get -y install libfftw3-dev python3-tk
sudo pip3 install numpy Cython
pip3 install scikit-build
sudo pip3 install GPy scanpy sklearn jupyter velocyto snakemake pytest fitsne plotly ggplot cmake jupyterlab spatialde polo rpy2 bbknn scvelo cellphonedb pyscenic
# sudo pip3 install wot (torch -> memory error in t2.micro)
#scanpy is incomplete. the docs argument you need to install these by hand, in this order
sudo apt install bison flex automake autoconf
## if you get error installing python-igrapy, upgrade pip3
sudo pip3 install python-igraph 
sudo pip3 install louvain leidenalg
sudo pip3 install scrublet cutadapt
#...and this also helps with run time, but is buried as a hint on one of the documentation pages
cd ~ && git clone https://github.com/DmitryUlyanov/Multicore-TSNE
cd Multicore-TSNE && sudo pip3 install .
cd ~ && sudo rm -r Multicore-TSNE
#other non-pip packages
cd ~ && git clone git://github.com/dpeerlab/Palantir.git
cd Palantir && sudo pip3 install .
cd ~ && sudo rm -r Palantir
sudo pip3 install tensorflow tensorflow-probability
cd ~ && git clone https://github.com/theislab/batchglm
cd batchglm && sudo pip3 install .
cd ~ && sudo rm -r batchglm
cd ~ && git clone https://github.com/theislab/diffxpy
cd diffxpy && sudo pip3 install .
cd ~ && sudo rm -r diffxpy

#post-jupyter setup of IRkernel
sudo R -e "devtools::install_github('IRkernel/IRkernel'); IRkernel::installspec()"

#libmaus2 and biobambam2, made easy again courtesy of a PPA
sudo add-apt-repository -y ppa:gt1/staden-io-lib-trunk-tischler
sudo add-apt-repository -y ppa:gt1/libmaus2
sudo add-apt-repository -y ppa:gt1/biobambam2
sudo apt-get update
sudo apt-get -y install libmaus2-dev biobambam2

#so this is apparently necessary
#or jupyter notebooks don't work
#sudo chown -R ubuntu ~/.local

#assorted Peng stuff
#sudo apt-get -y install python-pip
#sudo pip install numpy
#sudo pip install MACS2
#sudo apt-get -y install seqtk
#cd ~ && wget http://ccb.jhu.edu/software/hisat2/dl/hisat2-2.1.0-Linux_x86_64.zip
#unzip hisat2-2.1.0-Linux_x86_64.zip && rm hisat2-2.1.0-Linux_x86_64.zip
#wget -r -np -nH --cut-dirs 3 ftp://ftp.sanger.ac.uk/pub/users/kp9/UCSC ~
#chmod -R 755 ~/UCSC
#sudo pip3 install cutadapt scrublet
#cd ~ && git clone https://github.com/broadinstitute/picard.git
#cd picard && ./gradlew shadowJar

#the cloud is now ready for picture day!
#go back to eta, instances, create snapshot of the instance, name it something useful (basecloud comes to mind)
