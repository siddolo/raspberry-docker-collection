# Docker container collection for Raspberry PI 4

Docker container AArch64 (ARMv8) and AArch32 (ARMv7) collection for Raspberry PI 4

AArch64 (ARMv8) images require a 64 bit OS like [Raspberry PI OS aarm64](https://downloads.raspberrypi.org/raspios_arm64/images/) (currently in beta)



## How to run Docker + Portainer and configuring docker root storage to external USB3 device

Assuming that /dev/sda1 is USB3 storage...

### Install Docker
```bash
curl -sSL https://get.docker.com | sh
usermod -aG docker pi
```

### Stop Docker daemon
```bash
service docker stop
```

### Prepare external storage
```bash
mkfs.ext4 /dev/sda1
mkdir /mnt/external-storage
echo "/dev/sda1 /mnt/external-storage ext4 defaults,auto,users,rw,nofail,x-systemd.device-timeout=30 0 0" >> /etc/fstab
mount -a
```

### Move Docker storage root directory to external storage mountpoint
```bash
rsync -avP /var/lib/docker /mnt/external-storage/
sudo rm -rf /var/lib/docker

cat > /etc/docker/daemon.json <<EOF
{
   "data-root": "/mnt/external-storage/docker"
}
EOF
```

### Start Docker daemon
```bash
service docker start
```

### Run portainer
```bash
./portainer-ce.sh
```

### Opern Portainer

http://raspnerry.pi:9000/
