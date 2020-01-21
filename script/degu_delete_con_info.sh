#!/bin/sh
for i in $(find /sys/class/block/sd*/device/model)
do
    model=$(cat $i | sed 's/\s*$//')
    if [ "$model" = "ZEPHYR USB DISK" ] ; then
        degu=$(echo $i | sed -e "s/^.*block\/\(.*\)\/device.*/\1/g")
        dd if=/dev/zero of=/dev/$degu bs=1k count=16 seek=16 conv=fsync,nocreat
        cmp -n 16k -i 16k /dev/$degu /dev/zero
        result=$?
        if [ $result -eq 0 ] ; then
            echo "Successed delete degu connection information."
        else
            echo "Failed delete degu connection information."
        fi
    fi
done
if [ -z $degu ] ; then
    echo "Cannot find degu. Please connect degu to USB port."
fi
