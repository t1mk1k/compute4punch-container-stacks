FROM rockylinux:8
LABEL maintainer="Manuel Giffels <giffels@gmail.com>"

# Create links to point to scratch directory
RUN mkdir -p /scratch/etc/condor
RUN mkdir -p /scratch/var/log/condor
RUN mkdir -p /scratch/var/lib/condor
RUN mkdir -p /scratch/etc/cloud
RUN mkdir -p /scratch/var/lock/condor
RUN mkdir -p /scratch/var/run/condor

RUN ln -s /scratch/etc/condor /etc/condor
RUN ln -s /scratch/var/log/condor /var/log/condor
RUN ln -s /scratch/var/lib/condor /var/lib/condor
RUN ln -s /scratch/etc/cloud /etc/cloud
RUN ln -s /scratch/var/lock/condor /var/lock/condor
RUN ln -s /scratch/var/run/condor /var/run/condor

RUN rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
#RUN dnf install -y https://research.cs.wisc.edu/htcondor/repo/23.x/el8/x86_64/release/htcondor-release-23.x-1.el8.noarch.rpm
RUN dnf install -y https://research.cs.wisc.edu/htcondor/repo/23.x/el8/x86_64/release/condor-23.1.0-1.el8.x86_64.rpm

RUN dnf -y install epel-release && dnf clean all
RUN dnf config-manager --set-enabled powertools
RUN dnf -y install condor \
                   python39 \
                   ansible \
                   apptainer \
                   openssh-server \
                   xorg-x11-xauth \
                   langpacks-en \
                   glibc-langpack-en \
     && dnf clean all

# Get a newer Git version to use Git Protocol v2
RUN dnf -y install https://packages.endpointdev.com/rhel/8/main/x86_64/endpoint-repo.noarch.rpm \
    && dnf config-manager --disable endpoint \
    && dnf -y install --enablerepo endpoint git \
    && dnf clean all

RUN python3.9 -m pip install --no-cache-dir condor_git_config pexpect

# Add ansible community collection
RUN ansible-galaxy collection install community.general -p /usr/share/ansible/collections

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ansible_config /srv/ansible_config
COPY pilot_execute.sh /srv/pilot_execute.sh
RUN chmod +x /srv/pilot_execute.sh

# To establish ssh session: tell sshd not to chroot inside the container
RUN sed -i '/^UsePrivilegeSeparation/{h;s/.*/UsePrivilegeSeparation no/g};${x;/^$/{s//UsePrivilegeSeparation no/;H};x}' /usr/lib64/condor/condor_ssh_to_job_sshd_config_template

# To close ssh session: suppress tty from /etc/group
RUN sed -i '/tty/d' /etc/group

# Set language settings, ansible otherwise complains
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /scratch
ENTRYPOINT ["/tini", "-s", "--", "/srv/pilot_execute.sh"]
