FROM ubuntu

RUN apt-get update && \
    apt-get -y install emacs && \
    apt-get -y install tmux && \
    apt-get -y install zsh && \
    apt-get -y install mosh && \
    apt-get -y install less && \
    apt-get -y install git && \
    apt-get -y install git-flow && \
    apt-get -y install openssl && \
    apt-get -y install net-tools && \
    apt-get -y install curl && \
    apt-get -y install mosh && \
    apt-get -y install telnet

## install docker
RUN apt-get -y install apt-transport-https \
    	       	       ca-certificates \
		       curl \
		       software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt-get update && apt-get -y install docker-ce

## oh-my-zsh setup
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
COPY zsh-custom-themes/montuori.zsh-theme /root/.oh-my-zsh/custom/themes/
COPY zshrc /root/.zshrc

## emacs setup
RUN mkdir -p /root/.emacs.d/
COPY .emacs.d/ /root/.emacs.d/
COPY .emacs /root/.emacs

## tmux setup
COPY tmux.conf /root/.tmux.conf

## ssh setup
RUN mkdir /root/.ssh && chmod 700 /root/.ssh
COPY .ssh/config /root/.ssh/config


ENTRYPOINT /bin/zsh
