power-savings
=============

Power savings script for laptops running Ubuntu.

Tested on:
- Lenovo Thinkpad X220.

If you find that this script works on other laptops please send a
pull request.


Usage
-----

Copy the ```powerSavings.sh``` file to ```/etc/pm/power.d/``` and
```chmod +x``` it. The scripts in that folder get executed whenever a
power state change occurs e.g. you plug or unplug the AC adapter.
