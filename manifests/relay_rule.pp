# == Class: carbon::relay_rule
#
# Configures a carbon relay rule entry
#
define carbon::relay_rule(
  $destinations,
  $pattern = undef,
  $continue = undef,
  $prefix = '/opt/graphite',
  $order = 10,
) {

  concat::fragment { $title:
    target  => "${prefix}/conf/relay-rules.conf",
    content => template('carbon/relay_rule.erb'),
    order   => $order,
  }

}
