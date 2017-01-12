# PhenoMeNal H2020

FROM r-base:3.3.1

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

RUN apt-get -y update && apt-get -y --allow-downgrades install libssl-dev \
                                    libcurl4-openssl-dev git \
                                    libssh2-1-dev r-cran-ncdf4

# Add scripts folder to container
ADD scripts/runRamid.R /usr/bin/runRamid.R

# Add automatic repo finder for R:
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site


# Install ramid
RUN echo 'install.packages("devtools")' > install_ramid.R
RUN echo 'install.packages("optparse")' >> install_ramid.R
RUN echo 'library(devtools)' >> install_ramid.R
RUN echo 'install_github("seliv55/RaMID")' >> install_ramid.R

RUN Rscript install_ramid.R

# Clean up
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

RUN chmod +x /usr/bin/runRamid.R
# Define Entry point script
ENTRYPOINT ["runRamid.R"]
