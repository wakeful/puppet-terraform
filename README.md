# puppet-Terraform
Puppet Module for installing [Terraform](https://terraform.io/).

## Requirements
- Puppet >= v4.x

## Usage
```puppet
include terraform
```

```puppet
class { 'terraform':
  version => '0.6.16',
}
```
