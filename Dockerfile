FROM ubuntu:18.04

# docker run --rm -it z5.catmandu <args for catmandu>

# docker run --rm -it z5.catmandu \
#   convert Atom --url https://www.theregister.com/science/geeks_guide/headlines.atom to JSON | jq --color-output

# To run as current user:
# docker run --rm -it --user $(id -u):$(id -g) --volume $PWD:/workdir z5.catmandu <args for catmandu>

RUN apt-get update \
 && apt-get -y --no-install-recommends install \
    $(apt-cache search libcatmandu | cut -f1 -d ' ' | tr '\n' ' ') \
    build-essential libextutils-pkgconfig-perl \
    libpoppler-glib-dev libcairo-perl libglib-object-introspection-perl \
    cpanminus libyaml-dev \
 && apt-get -y autoclean \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /etc/apt/sources.list.d/

# liblog-log4perl-perl liblog-any-adapter-log4perl-perl \
# libxslt-dev libxml2-dev
# libpoppler-glib8

COPY rootfs /

RUN cpanm --notest --no-man-pages --installdeps --skip-satisfied . \
 && rm -rf /root/.cpanm

WORKDIR /workdir

ENTRYPOINT ["/usr/bin/catmandu"]
