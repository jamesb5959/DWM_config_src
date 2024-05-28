# From a live USB
# Identify the disk and partitions
lsblk

# Close the LUKS partition
sudo cryptsetup luksClose /dev/mapper/root

# Overwrite with random data
sudo dd if=/dev/urandom of=/dev/nvme0n1 bs=1M status=progress

# (Optional) Use shred for multiple overwrites
sudo shred -v -n 3 /dev/nvme0n1

# Issue TRIM command for SSD
sudo blkdiscard /dev/nvme0n1

# Reformat the disk if needed
sudo fdisk /dev/nvme0n1
