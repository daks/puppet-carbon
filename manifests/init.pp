class carbon(
  $prefix = '/opt/graphite',
  $source = 'https://github.com/graphite-project/carbon.git',
  $path = '/usr/local/src/carbon',
  $revision = 'master',
  $schemas = {
    'carbon' => {
      pattern    => '^carbon\.',
      retentions => '60:90d',
    },
    'default_1min_for_1day' => {
      pattern    => '.*',
      retentions => '60s:1d',
    },
  },
) {

  class { 'carbon::install':
    prefix   => $prefix,
    source   => $source,
    path     => $path,
    revision => $revision,
  }

  class { 'carbon::config':
    prefix  => $prefix,
    schemas => $schemas,
    require => Class['carbon::install'],
  }

}
