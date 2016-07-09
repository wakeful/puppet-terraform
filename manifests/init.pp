class terraform (
  $version = '0.6.16',
  $cache_dir = '/tmp/terraform',
  $bin_dir = '/usr/local/bin',
  $base_url = 'https://releases.hashicorp.com/terraform/',
) {

  $_os = $::kernel ? {
    'Linux' => 'linux',
    'FreeBSD' => 'freebsd',
    'OpenBSD' => 'openbsd',
  }

  if $::architecture in ['x86_64', 'amd64', 'x64'] {
    $_arch = 'amd64'
  } else {
    $_arch = '386'
  }

  $terraform_zip = "terraform_${version}_${_os}_${_arch}.zip"
  $terraform_url = "${base_url}${version}/${terraform_zip}"

  file { $cache_dir:
    ensure => directory,
    owner => 'root',
    mode => '0644',
  }

  file { 'download-terraform':
    path => "${cache_dir}/${terraform_zip}",
    source => $terraform_url,
    require => File[$cache_dir],
  }

  exec { 'install terraform': 
    command => "unzip ${cache_dir}/${terraform_zip}",
    cwd => $bin_dir,
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require => File['download-terraform'],
  }

}