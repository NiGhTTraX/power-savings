#!/bin/bash

# When we switch to battery, toggle some power savings on. When we go back to
# AC power, switch them off.

if [[ $1 == false ]]; then
	echo `date` "Switching to AC settings" >> /var/log/power.log

	# Disable laptop mode
	#echo 0 > /proc/sys/vm/laptop_mode

	# NMI watchdog should be turned on
	for foo in /proc/sys/kernel/nmi_watchdog;
	do echo 1 > $foo;
	done

	# Set SATA channel: max performance
	for foo in /sys/class/scsi_host/host*/link_power_management_policy;
	do echo max_performance > $foo;
	done

	# CPU Governor: ondemand
	for foo in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
		do echo ondemand > $foo;
	done

	# Disable USB autosuspend
	for foo in /sys/bus/usb/devices/*/power/level;
		do echo on > $foo;
	done

	# Disable PCI autosuspend
	for foo in /sys/bus/pci/devices/*/power/control;
		do echo on > $foo;
	done

	# Disable audio_card power saving
	echo 0 > /sys/module/snd_hda_intel/parameters/power_save_controller
	echo 0 > /sys/module/snd_hda_intel/parameters/power_save

	# Restore screen brightness.
	echo 14 > /sys/class/backlight/acpi_video0/brightness

elif [[ $1 == true ]]; then
	echo `date` "Switching to battery settings" >> /var/log/power.log

	# Enable Laptop-Mode disk writing
	#echo 5 > /proc/sys/vm/laptop_mode

	# NMI watchdog should be turned off
	for foo in /proc/sys/kernel/nmi_watchdog;
		do echo 0 > $foo;
	done

	# Set SATA channel to power saving
	for foo in /sys/class/scsi_host/host*/link_power_management_policy;
		do echo min_power > $foo;
	done

	# Select powersave CPU Governor
	for foo in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
		do echo powersave > $foo;
	done

	# Activate USB autosuspend
	for foo in /sys/bus/usb/devices/*/power/level;
		do echo auto > $foo;
	done

	# Activate PCI autosuspend
	for foo in /sys/bus/pci/devices/*/power/control;
		do echo auto > $foo;
	done

	# Activate audio card power saving
	# (sounds shorter than 5 seconds will not be played)
	echo 5 > /sys/module/snd_hda_intel/parameters/power_save
	echo 1 > /sys/module/snd_hda_intel/parameters/power_save_controller

	# Dim the screen.
	echo 10 > /sys/class/backlight/acpi_video0/brightness

fi

