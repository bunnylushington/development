# A Docker Development Environment

## What is it?

This repository represents the configuration of a Docker container and
application stack that can be deployed to a Docker machine.  After being
setup, it provides for a standardized way of approaching all development
projects.  Security and functionality are not foresaken in the name of
repeatability.

## Rationale

Local development is great, especially when it employs Docker containers for
the application under development.  Unfortunately, there are some gotchas:

  - On older Mac hardware, Docker runs ... okay, usually, but things heat
    up fast and memory can become an issue.

  - Docker containers are usually pretty small but over a slow hotspot it
    can take hours for all the pieces of an application to download.

  - Maintaining emacs and tmux configurations across all possible dev
    environments is a pain.  True, Dropbox and GitHub can help but it's
    a largely manual process.

  - Developing from the iPad Pro is now a thing.

## How-To

### Provision a Host

I use DigitalOcean's Ubuntu-based Docker VM available from the DO Marketplace.
The instance I find acceptable for development use is $20/month.  Once the host
is provisioned, there's some setup to be done.

### Docker Machine Setup

First, I find Mosh to be a handy utility, especially over transient networks.
To prepare to use Mosh:

```
apt-get install mosh
ufw allow 60000:61000/udp
```

It's generally helpful to have a reasonable SSH environment configured.  To that
end, I create `/root/.ssh/config` and a private key, ensuring that the file
permissions are correct.  Once that's in place:

```
eval $(ssh-agent)
ssh-add /root/.ssh/private_key
```

While using the development container, starting the ssh-agent is not optional.
(Well, it is but the environment variable SSH_AUTH_SOCK must be set to an
existing directory on the Docker machine filesystem.)

### Running the development Container

First set the Docker machine into swarm mode:

```
docker swarm init \
  --advertise-addr=$(ip route get 8.8.8.8 | awk '{print $7}')
```

Now clone the development container repository:

```
git clone git@github.com:bunnylushington/development
```

In that repository there is a little shell script `ctl` that helps automate some
of the remaining steps.  The first step is to build the development container:

```
./ctl build
```

Once built, the container can be run:

```
./ctl start
```

This command will also start a ipsec VPN container, more below.

The running development container can be attached to with

```
./ctl shell
```

and stopped with

```
./ctl stop
```


## Some Possibilities

There are a couple of conveniences that have been setup.  The first is the
propogation of the SSH authentication agent.  Keys that have been added to
the agent on the Docker machine are now available on the development container
as well (which might make git cloning, say, easier).

The second convenience is the ability to run Docker commands in the developemnt
container.  This allows development inside application specific containers to
happen from within the development container.  It is important to note that the
secondary containers (let's say a PGSQL DB container) will map volumes from
the Docker machine that's running the development (and PGSQL DB) container, not
the development container itself.  So volumes can be persistent even if the
devbelopment container is terminated.

The filesystem /projects is mounted from the Docker machine into the development
container.  It's expected that code under development will reside here (but
that's just a convenience).

## In Use

### Colors

To get a nice usable 256 color palatte in (terminal) emacs, there were
a few configuration steps:

  - Set iTerm2 to report the terminal type `xterm-256color`
  - `export TERM=xterm-256color` in .zshrc
  - `alias tmux="tmux -2"`
  - `set -g default-terminal "screen-256color"` in .tmux.conf
  
After this, things started working okay.  Seems a little like waving a
rubber chicken but it solved the problem.  You can test the color palette
in emacs with `M-x list-color-display`.

### The Meta Key

I've been using the key immediately to the left of the space bar as meta
for so long that remapping my brain would be hard.  To solve the issue of 
emacs + iTerm2, I adjusted three iTerm2 settings:

  - profiles > keys > left option key sends: Esc+
  - keys > left option key: left command
  - keys > left command key: left option
  
so M-x is what I think it is.  Also, I set the iTerm2 profile to
ignore cmd-w to prevent accidentally closing windows.
  

## Security

Out of the box, the DO VM allows throttled access to port 22, which
provides for SSH access.  Above we also opened up some UDP ports for
mosh communication.  The ipsec VPN conveniently allows for all the
ports on the host to be accessed by a client VPN'd into the Docker
machine.  So while ports must be mapped from containers back to the
DM, there's no need to create SSH tunnels everywhere.

## Last Thoughts

This might not be a great solution.  I have a need for remote Docker-based
application development and standardizing how this works makes sense for my
usecase.  
