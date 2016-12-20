define apt::conf (
  Optional[Variant[String, Stdlib::Compat::String]] $content                          = undef,
  Enum['present', 'absent'] $ensure                                                   = present,
  Variant[String, Stdlib::Compat::String, Integer, Stdlib::Compat::Integer] $priority = 50,
  Optional[Boolean] $notify_update                                                    = undef,
) {

  unless $ensure == 'absent' {
    unless $content {
      fail('Need to pass in content parameter')
    }
  }

  $confheadertmp = epp('apt/_conf_header.epp')
  $conftmp = epp('apt/conf.epp', { 'content' => $content })
  apt::setting { "conf-${name}":
    ensure        => $ensure,
    priority      => $priority,
    content       => "${confheadertmp}${conftmp}",
    notify_update => $notify_update,
  }
}
