#### To increase disk size on vagrant

- Install plugin

```
vagrant plugin install vagrant-disksize
```

- Modify vagrant file

```
Vagrant.configure("2") do |config|
    config.vm.box = "debian/stretch64"
    config.disksize.size = "20GB"
end
```

#### To copy a file from vagrant VM to host

```
scp -i <private_key> -P 2222 vagrant@127.0.0.1:<source> <destination>
```
