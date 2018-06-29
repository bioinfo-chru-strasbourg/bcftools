FROM centos
MAINTAINER Antony Le Bechec <antony.lebechec@gmail.com>

##############################################################
# Dockerfile Version:   1.0
# Software:             BCFTOOLS
# Software Version:     1.8
# Software Website:     https://github.com/samtools/samtools/
# Description:          BCFTOOLS
##############################################################


#######
# YUM #
#######

#RUN yum update -y
RUN yum install -y zlib-devel zlib \
                  zlib2-devel zlib2 \
                  bzip2-devel bzip2 \
                  lzma-devel lzma \
                  xz-devel xz \
                  ncurses-devel \
                  wget \
                  gcc \
                  make ;
RUN yum clean all ;


##########
# HTSLIB #
##########

ENV TOOLS=/home/TOOLS/tools
ENV TOOL_NAME=htslib
ENV TOOL_VERSION=1.8
ENV TARBALL_LOCATION=https://github.com/samtools/$TOOL_NAME/releases/download/$TOOL_VERSION/
ENV TARBALL=$TOOL_NAME-$TOOL_VERSION.tar.bz2
ENV DEST=$TOOLS/$TOOL_NAME/$TOOL_VERSION
ENV PATH=$TOOLS/$TOOL_NAME/$TOOL_VERSION/bin:$PATH

# INSTALL
RUN wget $TARBALL_LOCATION/$TARBALL ; \
    tar xf $TARBALL ; \
    rm -rf $TARBALL ; \
    cd $TOOL_NAME-$TOOL_VERSION ; \
    make prefix=$TOOLS/$TOOL_NAME/$TOOL_VERSION install ; \
    cd ../ ; \
    rm -rf $TOOL_NAME-$TOOL_VERSION


############
# BCFTOOLS #
############

ENV TOOLS=/home/TOOLS/tools
ENV TOOL_NAME=bcftools
ENV TOOL_VERSION=1.8
ENV TARBALL_LOCATION=https://github.com/samtools/$TOOL_NAME/releases/download/$TOOL_VERSION/
ENV TARBALL=$TOOL_NAME-$TOOL_VERSION.tar.bz2
ENV DEST=$TOOLS/$TOOL_NAME/$TOOL_VERSION
ENV PATH=$TOOLS/$TOOL_NAME/$TOOL_VERSION/bin:$PATH

# INSTALL
RUN wget $TARBALL_LOCATION/$TARBALL ; \
    tar xf $TARBALL ; \
    rm -rf $TARBALL ; \
    cd $TOOL_NAME-$TOOL_VERSION ; \
    make prefix=$TOOLS/$TOOL_NAME/$TOOL_VERSION install ; \
    cd ../ ; \
    rm -rf $TOOL_NAME-$TOOL_VERSION


#######
# YUM #
#######

RUN yum erase -y zlib-devel \
                  zlib2-devel \
                  bzip2-devel \
                  lzma-devel \
                  xz-devel \
                  ncurses-devel \
                  wget \
                  gcc \
                  make ;
RUN yum clean all ;


CMD ["/bin/bash"]
