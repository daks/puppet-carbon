class carbon::config(
  $prefix = '/opt/graphite',
  $caches = {},
  $relays = {},
  $schemas = {},
) {

  concat { "${prefix}/conf/carbon.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment { 'header':
    target  => "${prefix}/conf/carbon.conf",
    content => "### PUPPET MANAGED ###\n",
    order   => 1,
  }

  concat { "${prefix}/conf/storage-schemas.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  create_resources('carbon::schema', $schemas)
  create_resources('carbon::cache', $caches)
  create_resources('carbon::relay', $relays)

}
