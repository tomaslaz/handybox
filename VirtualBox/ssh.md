# Seeting up SSH from Host (MacOS) into Guest Machine (VM, Ubuntu 18)

## On the Host:
- Global Tools > Host Network Manager > create
By the default it should add ```vboxnet0```
- VM > Settings > Network >

**Adapter 1**
Attached to: NAT

Advanced > Port Forwarding
Add a rule:
```
| Name | Protocol | Host IP | Host Port | Guest IP | Guest Port |
|------|----------|---------|-----------|----------|------------|
|  SSH |    TCP   |         |    2222   |          |     22     |
```

**Adapter 2**
Attached to: Host-only Adapter
Name: vboxnet0

## On the Guest:

- Install SSH server
```
sudo apt-get update
sudo apt-get install openssh-server
```

# How to use it:

```ssh <username>@localhost -p 2222```
