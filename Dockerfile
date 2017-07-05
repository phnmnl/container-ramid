# PhenoMeNal H2020

FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:v3.4.1-1xenial0_cv0.2.12

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL version="1.0"
LABEL software.version="1.0"
LABEL software="ramid"
LABEL description="Evaluates the peaks of mass isotopomer distribution (MID), making them ready for correction for natural isotope occurrence."
LABEL website="https://github.com/seliv55/ramid"
LABEL documentation="https://github.com/phnmnl/container-ramid/blob/master/README.md"
LABEL license="https://github.com/phnmnl/container-ramid/blob/develop/License.txt"
LABEL tags="Metabolomics"

ENV RAMID_REVISION "4c372385c9a4b043c8be028cf75380ff6c3875e3"

# Setup package repos
RUN apt-get -y update && apt-get -y --no-install-recommends install r-base-dev libssl-dev \
                                    libcurl4-openssl-dev git \
                                    libssh2-1-dev r-cran-ncdf4 && \
    echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site && \
    R -e "install.packages(c('devtools', 'optparse'))" && \
    R -e 'library(devtools); install_github("seliv55/RaMID",ref=Sys.getenv("RAMID_REVISION")[1])' && \
    apt-get purge -y git r-base-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev && \
    apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Add scripts folder to container
ADD scripts/runRamid.R /usr/bin/runRamid.R
RUN chmod +x /usr/bin/runRamid.R

# Add test scripts
ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod a+x /usr/local/bin/runTest1.sh
# Define Entry point script
ENTRYPOINT ["runRamid.R"]
