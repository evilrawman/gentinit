# Adjust this variables according to your previous configuration
gentooDir="/mnt/gentoo"
bootDir="${gentooDir}/boot"
gentooSd="/dev/sda4"
bootSd="/dev/sda2"


# Checking if partitions do exist
#sdaList=`ls /dev/sda*`
#if echo "$sdaList" | grep -q "$gentooSd";
#then
#	echo "[!] ERROR: Partition $gentooSd does not exist."
#fi


# Mounting Gentoo partitions
if -qs '${gentooDir} # Checking if gentoo's root partition is mounted
then
	echo "[i] The directory \"$gentooDir\" is already mounted."
else
	mkdir "${gentooDir}"
	mount "${gentooSd}" "${gentooDir}"
fi

if mountpoint -q $bootDir # Checking if boot partition is mounted
then
	echo "[i] The directory \"$bootDir\" is already mounted."
else
	mkdir "${bootDir}"
	mount "${bootSd}" "${bootDir}"
fi

# Preparing for Gentoo chroot
mount -t proc /proc "${gentooDir}/proc"
mount --rbind /sys "${gentooDir}/sys"
mount --rbind /dev "${gentooDir}/dev"


# Showing user the necessary commands for chrooting to Gentoo
echo ""
echo "[i] Now paste the next lines to chroot to Gentoo:"
echo ""
echo "chroot ${gentooDir} /bin/bash"
echo "source /etc/profile"
echo "export PS1=\"(chroot) \$PS1\""
