FROM fedora:28
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

RUN dnf -y install mod_perl git sudo perl-App-cpanminus perl-CPAN \
                   gcc gcc-c++ make vim-enhanced perl-Software-License gd-devel \
                   openssl-devel ImageMagick-devel graphviz patch patchutils \
                   perl-GD perl-GDGraph perl-GDTextUtil && \
    dnf -y install https://dev.mysql.com/get/mysql-community-client-8.0.12-1.fc28.x86_64.rpm \
                   https://dev.mysql.com/get/mysql-community-libs-8.0.12-1.fc28.x86_64.rpm \
                   https://dev.mysql.com/get/mysql-community-devel-8.0.12-1.fc28.x86_64.rpm \
                   https://dev.mysql.com/get/mysql-community-common-8.0.12-1.fc28.x86_64.rpm && \
    dnf -y update && \
    dnf clean all

RUN useradd -m -G wheel -u 1000 -s /bin/bash bugzilla && \
    cpanm --quiet --notest --skip-installed DateTime && \
    cpanm --quiet --notest --skip-installed Module::Build && \
    cpanm --quiet --notest --skip-installed Software::License && \
    cpanm --quiet --notest --skip-installed Pod::Coverage && \
    cpanm --quiet --notest --skip-installed Cache::Memcached::GetParserXS && \
    cpanm --quiet --notest --skip-installed XMLRPC::Lite && \
    cpanm --quiet --notest --skip-installed DBD::mysql && \
    cpanm --quiet --notest --skip-installed Memoize && \
    cpanm --quiet --notest --skip-installed HTML::FormatText::WithLinks && \
    cpanm --quiet --notest --skip-installed Chart::Lines && \
    cpanm --quiet --notest --skip-installed Template::Plugin::GD::Image && \
    git clone -b 5.0 https://github.com/bugzilla/bugzilla.git /opt/bugzilla && \
    cd /opt/bugzilla && cpanm --quiet --notest --skip-installed --installdeps --with-recommends . && \
    chown -R bugzilla:bugzilla /opt/bugzilla && \
    rm /etc/httpd/conf.d/welcome.conf

COPY files /

EXPOSE 80

CMD ["/usr/local/sbin/init-container"]
