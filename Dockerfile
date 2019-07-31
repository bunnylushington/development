FROM ubuntu

RUN apt-get update && \
	apt-get -y install tmux zsh mosh less git git-flow openssl \
	net-tools curl mosh telnet source-highlight xsel xclip emacs \
	postgresql-client


## install docker
RUN apt-get -y install apt-transport-https \
    	       	       ca-certificates \
		       curl \
		       software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt-get update && apt-get -y install docker-ce

## Erlang setup
RUN curl --output /tmp/es.deb https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
	&& dpkg -i /tmp/es.deb \
	&& curl --output /tmp/es.asc https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
	&& apt-key add /tmp/es.asc \
	&& apt-get update \
	&& apt-get -y install esl-erlang

## oh-my-zsh setup
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
COPY zsh-custom-themes/montuori.zsh-theme /root/.oh-my-zsh/custom/themes/
COPY zshrc /root/.zshrc

## emacs setup
RUN mkdir -p /root/.emacs.d/
COPY .emacs.d/ /root/.emacs.d/
COPY .emacs /root/.emacs
RUN emacs -Q -batch -l /root/.emacs.d/init-packages.el --eval=t

## tmux setup
COPY tmux.conf /root/.tmux.conf

## git setup
COPY gitconfig /root/.gitconfig

## ssh setup
RUN mkdir /root/.ssh && chmod 700 /root/.ssh
COPY .ssh/config /root/.ssh/config

## set the default shell
RUN chsh --shell /bin/zsh

ENTRYPOINT /bin/zsh
