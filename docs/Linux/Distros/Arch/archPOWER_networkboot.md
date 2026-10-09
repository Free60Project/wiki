# Use archPOWER installer-ISO to setup network booting via XeLL (TFTP/NFS)

This is intentionally kept pretty barebone.

For details on NFS/Network booting see: [NFS-Root](../../../NFS_Root.md)

This how-to was tested on Fedora 45.

It assumes the following target configuration:

You are running these commands as root (why? because I do not like to prepend `sudo` on pretty much every line of these instructions)

- TFTP root: `/srv/tftp`
- NFS root: `/srv/nfs`
- Archpower NFS will be served from: `/srv/nfs/archpower`
- Network interface towards X360: `ens42u3`
- Host IP: `192.168.42.1`
- DHCP IP range: `192.168.42.25-192.168.42.50`

NOTE: This will not do any IP forwarding, your xbox linux target is isolated from the internet.

- Install dependencies on host machine

Fedora

`dnf install squashfs-tools nfs-utils dnsmasq`

Debian

`apt install nfs-kernel-server dnsmasq squashfs`

- Create directory structure

```
mkdir /mnt/archiso
mkdir /srv/tftp
mkdir -p /srv/nfsroot/archpower
```
- Download archpower ISO

```
wget https://archlinuxpower.org/iso/archpower-current-xenon.iso
wget https://archlinuxpower.org/iso/archpower-current-xenon.iso.sig
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys B96775F34689694C
# Verify
gpg --verify archpower-current-xenon.iso.sig archpower-current-xenon.iso
```

- Mount archpower ISO

`mount -o loop,ro archpower-current-xenon.iso /mnt/archiso`

- Extract rootfs to NFS-reachable directory

`unsquashfs -d /srv/nfsroot/archpower airootfs.sfs`

- Copy kernel image

`cp /mnt/archiso/arch/boot/ppc/vmlinuz-linux-xenon /srv/tftp/`

- Unmount archpower ISO

`umount /mnt/archiso`

- Edit kboot.conf

`nano /srv/tftp/kboot.conf`

```
timeout=5
default=archpower_nfsboot

archpower_nfsboot="/vmlinuz-linux-xenon root=/dev/nfs nfsroot=192.168.42.1:/srv/nfs/archpower init=/usr/sbin/init rw ip=dhcp coherent_pool=16M"
```

- Allow ports in firewall

```
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpcbind
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=tftp
firewall-cmd --reload
```

- If your Host has SELinux enabled (check with `getenforce`), setup correct SELinux labels for TFTP directory

```
semanage fcontext -a -t tftpdir_t '/srv/tftp(/.*)?'
restorecon -Rv /srv/tftp
```

- Enable NFS server

```
systemctl enable --now nfs-server.service 
# Verify it started properly
systemctl status nfs-server.service 
```

- Setup NFS export

`nano /etc/exports`

```
/srv/nfs/archpower  192.168.42.0/24(rw,sync,no_root_squash,no_subtree_check)
```

- Re-read the updated exports definition

`exportfs -arv`

- Setup DNSMasq to be DHCP and TFTP server

`nano /etc/dnsmasq.conf`

```
bind-interfaces
dhcp-authoritative
no-resolv

enable-tftp
tftp-root=/srv/tftp

interface=ens42u3

dhcp-option=3,192.168.42.1
dhcp-option=6,192.168.42.1
dhcp-range=192.168.42.25,192.168.42.50,12h

# Static DHCP Lease
dhcp-host=00:22:48:4d:4b:37,XeLL,192.168.42.29,3d
# TFTP
dhcp-boot=tag:XeLL,xenon.elf,,192.168.42.1
```

- Start DNSMasq

```
systemctl enable --now dnsmasq
systemctl status dnsmasq
```

- NFS root customizations to auto-enable SSH and drop you into a running system

Enable SSHD service

`systemctl --root=/srv/nfs/archpower enable sshd.service`

Generate SSH Host keys

```
cd /srv/nfs/archpower/etc/ssh

ssh-keygen -t rsa -f /srv/nfs/archpower/etc/ssh/ssh_host_rsa_key -N ""
ssh-keygen -t dsa -f /srv/nfs/archpower/etc/ssh/ssh_host_dsa_key -N ""
ssh-keygen -t ecdsa -f /srv/nfs/archpower/etc/ssh/ssh_host_ecdsa_key -N ""
ssh-keygen -t ed25519 -f /srv/nfs/archpower/etc/ssh/ssh_host_ed25519_key -N ""
```

Set your own, personal SSH pubkey as authorized

```
mkdir -p /srv/nfs/archpower/root/.ssh
# Add your own SSH pubkey now
nano /srv/nfs/archpower/root/.ssh/authorized_keys
# Adjust ACL
chmod 700 /srv/nfs/archpower/root/.ssh
chmod 600 /srv/nfs/archpower/root/.ssh/authorized_keys
```

Disable systemd-firstboot.
This will make the system boot directly to the login prompt.

```
mv /srv/nfs/archpower/usr/lib/systemd/system/systemd-firstboot.service /srv/nfs/archpower/usr/lib/systemd/system/_systemd-firstboot.service.bak
```

- If everything done correctly, XeLL should get your static IP, download the bootentry via TFTP, chainload the kernel and boot into the system.
