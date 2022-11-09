FROM centos:7
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
RUN yum install -y https://research.cs.wisc.edu/htcondor/repo/9.0/htcondor-release-current.el7.noarch.rpm

RUN yum -y install epel-release && yum clean all
RUN yum -y install condor \
                   python36 \
                   ansible \
                   apptainer \
                   tsocks \
                   openssh-server.x86_64 \                   
     && yum clean all

# Get a newer Git version to use Git Protocol v2 
RUN yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo-1.10-1.x86_64.rpm \
    && yum-config-manager --disable endpoint \
    && yum -y install --enablerepo endpoint git \
    && yum clean all

RUN python3.6 -m pip install --no-cache-dir condor_git_config pexpect

# Add ansible community collection
RUN ansible-galaxy collection install community.general -p /usr/share/ansible/collections

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ansible_config /srv/ansible_config
COPY pilot_execute.sh /srv/pilot_execute.sh
RUN chmod +x /srv/pilot_execute.sh

COPY ldconfig_wrapper.sh /usr/local/bin/ldconfig
COPY singularity_nv_setup.sh /etc/profile.d/singularity_nv_setup.sh

# Tell sshd not to chroot inside the container 
RUN sed -i '/^UsePrivilegeSeparation/{h;s/.*/UsePrivilegeSeparation no/g};${x;/^$/{s//UsePrivilegeSeparation no/;H};x}' /usr/lib64/condor/condor_ssh_to_job_sshd_config_template

# Define the address family
RUN sed -i '/^AddressFamily/{h;s/.*/AddressFamily inet/g};${x;/^$/{s//AddressFamily inet/;H};x}' /usr/lib64/condor/condor_ssh_to_job_sshd_config_template

# Add wrapper for xauth to solve issues related to X11 forwarding
RUN sed -i '/^XAuthLocation/{h;s/.*/XAuthLocation \/usr\/local\/bin\/condor_xauth_wrapper/g};${x;/^$/{s//XAuthLocation \/usr\/local\/bin\/condor_xauth_wrapper/;H};x}' /usr/lib64/condor/condor_ssh_to_job_sshd_config_template

WORKDIR /scratch
ENTRYPOINT ["/tini", "-s", "--", "/srv/pilot_execute.sh"]
