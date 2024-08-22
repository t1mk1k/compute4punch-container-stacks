FROM rockylinux:9
LABEL maintainer="Manuel Giffels <giffels@gmail.com>"

RUN dnf update -y && dnf clean -y all
RUN dnf install -y epel-release \
                   https://linuxsoft.cern.ch/wlcg/el9/x86_64/wlcg-repo-1.0.0-1.el9.noarch.rpm
                   # http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm
RUN cd /etc/yum.repos.d/ && curl -O https://repository.egi.eu/sw/production/cas/1/current/repo-files/egi-trustanchors.repo
RUN dnf update -y && dnf clean -y all
RUN dnf --enablerepo=crb install -y apptainer cvmfs HEP_OSlibs wn ui tcsh openssh-server.x86_64 xorg-x11-xauth python3 bc davix && \
    dnf clean -y all

# Accept old Grid CAs
RUN update-crypto-policies --set DEFAULT:SHA1

RUN sed -i "s%allow setuid = yes%allow setuid = no%g" /etc/apptainer/apptainer.conf
RUN sed -i "s%mount devpts = yes%mount devpts = no%g" /etc/apptainer/apptainer.conf

RUN rm -rf /etc/grid-security/certificates && ln -s /cvmfs/grid.cern.ch/etc/grid-security/certificates/ /etc/grid-security/certificates

RUN echo "export MACHINEFEATURES=/etc/machinefeatures" > /etc/profile.d/grid_env.sh
RUN echo "export VO_ATLAS_SW_DIR=/cvmfs/atlas.cern.ch/repo/sw" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_AUGER_SW_DIR=/cvmfs/auger.egi.eu" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_BELLE_SW_DIR=/cvmfs/belle.cern.ch/sl6" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_LHCB_SW_DIR=/cvmfs/lhcb.cern.ch" >> /etc/profile.d/grid_env.sh
RUN echo "export X509_CERT_DIR=/etc/grid-security/certificates" >> /etc/profile.d/grid_env.sh

# define environment variables HOME and TERM
COPY fix_singularity_env.sh /etc/profile.d/fix_singularity_env.sh
RUN chmod +x /etc/profile.d/fix_singularity_env.sh
