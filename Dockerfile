# "#################################################"
# Dockerfile to build a GitHub Pages Jekyll site
#   - Ubuntu 22.04
#   - Ruby 3.1.2
#   - Jekyll 3.9.3
#   - GitHub Pages 288
#
#   This code is from the following Gist:
#   https://gist.github.com/BillRaymond/db761d6b53dc4a237b095819d33c7332#file-post-run-txt
#
# Instructions:
#  1. Copy all the text in this file
#  2. Create a file named Dockerfile and paste the code
#  3. Create the Docker image/container
#  4. Locate the shell file in this Gist file and run it in the local repo's root
# "#################################################"
FROM ubuntu:22.04

# "#################################################"
# "Get the latest APT packages"
# "apt-get update"
RUN apt-get update

# "#################################################"
# "Install Ubuntu prerequisites for Ruby and GitHub Pages (Jekyll)"
# "Partially based on https://gist.github.com/jhonnymoreira/777555ea809fd2f7c2ddf71540090526"
RUN apt-get -y install git \
    curl \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm6 \
    libgdbm-dev \
    libdb-dev \
    apt-utils
    
# "#################################################"
# "GitHub Pages/Jekyll is based on Ruby. Set the version and path"
# "As of this writing, use Ruby 3.1.2
# "Based on: https://talk.jekyllrb.com/t/liquid-4-0-3-tainted/7946/12"
ENV RBENV_ROOT /usr/local/src/rbenv
ENV RUBY_VERSION 3.1.2
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH

# "#################################################"
# "Install rbenv to manage Ruby versions"
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
  && git clone https://github.com/rbenv/ruby-build.git \
    ${RBENV_ROOT}/plugins/ruby-build \
  && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

# "#################################################"
# "Install ruby and set the global version"
RUN rbenv install ${RUBY_VERSION} \
  && rbenv global ${RUBY_VERSION}

# "#################################################"
# "Install the version of Jekyll that GitHub Pages supports"
# "Based on: https://pages.github.com/versions/"
# "Note: If you always want the latest 3.9.x version,"
# "       use this line instead:"
# "       RUN gem install jekyll -v '~>3.9'"
RUN gem install jekyll -v '3.9.5'
