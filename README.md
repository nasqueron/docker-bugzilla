## Bugzilla Docker image 

Provide a Bugzilla stable version, with CPAN modules.

### Usage

To start a container linked against a MySQL container:

```bash
$ docker run -dt -p 8080:80 --link mysql:somemysqlcontainer \
  -e DB_HOST=mysql -e DB_USER=bugs -e DB_PASSWORD=bugs \
  -e BUGZILLA_URL=https://bugzilla.domain.tld
  nasqueron/bugzilla
```

To use networks, replace the `--link` option by a network configuration.

### Credits

The dependencies and the configuration variables to provide
are partially based on Dave Lawrence (dklawren) work.
