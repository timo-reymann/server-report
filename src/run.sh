#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Require root
if [ "$(whoami)" != "root" ]; then
        echo "ERROR Report can only be run as root"
        exit -1
fi

# Check if config file exists
if [ ! -f "$SCRIPT_DIR/config" ]; then
    echo "ERROR Config File not found! Consider copying config.sample to config and adjust it to your needs"
    exit 1;
fi

# Load configuration
source "$SCRIPT_DIR/config"


# Get disks usage from df -h via disk name (partials are also working or grep patterns)
function get_disk_space() {
    PERCENTAGE="$(df -h | grep $1 | awk '{ print $5 }' | tail -n 1 | sed 's/;$//')";
    echo "${PERCENTAGE:: -1}"
}


# Output stuff
function output() {
    echo -e "$1"
    echo -e $1 >> $SCRIPT_DIR/report.log
}


# Get current output
function get_output() {
    cat $SCRIPT_DIR/report.log
}


# Get memory value from /proc/meminfo by its key
function get_memory_value() {
    echo "$(grep $1 /proc/meminfo | awk '{print $2}')"
}


# Format byte value passed via first parameter and append MB to output
function format_byte_value() {
    DIVISION=($1/1024)
    RESULT="$(echo $DIVISION | bc)"
    echo $RESULT "MB"
}


# Print partial heading for part of script
function part_heading() {
    output "\n==========================="
    output "\t$1"
    output "==========================="
}


# Indent line(s)
indent() {
    sed 's/^/   /'
}


# Print general info
part_heading "INFO"
output "Date: $(date +%Y-%m-%d)" | indent
output "Time: $(date +%H:%M:%S)" | indent
output "IPs:  $(hostname -I)" | indent


# Disk health
part_heading "DISK SPACE"
for disk in ${DISKS_TO_CHECK[@]}
do
    FREE_DISK_SPACE="$(get_disk_space $disk)"

    if [ $FREE_DISK_SPACE -ge $WARN_DISK_USAGE  ]
    then
        output "$disk: WARNING. Over $WARN_DISK_USAGE % disk usage!" | indent
    else
        output "$disk: OK ($FREE_DISK_SPACE %)" | indent
    fi

done


# Ram
part_heading "RAM USAGE"
output "Total: $(format_byte_value $(get_memory_value MemTotal))" | indent
output "Free: $(format_byte_value $(get_memory_value MemFree))" | indent


# Swap
part_heading "SWAP USAGE"
output "Total: $(format_byte_value $(get_memory_value SwapTotal))" | indent
output "Free: $(format_byte_value $(get_memory_value SwapFree))" | indent


# Updates
part_heading "Updates"
output "$( /usr/lib/update-notifier/apt-check --human-readable)" | indent


# Docker status, if installed
part_heading "DOCKER STATS"

which docker > /dev/null

if [ $? -eq 1 ]
then
    output "Docker not found, no healthchecks run" 
    exit 0
fi

output "$(docker stats --no-stream --format 'table {{.Name}}\t{{.MemPerc}}\t{{.CPUPerc}}\t{{.NetIO}}\t{{.BlockIO}}')" | indent


# Plugins
part_heading "PLUGINS"
PLUGINS=$(find $SCRIPT_DIR/plugins/* 2> /dev/null)
for f in ${PLUGINS[@]};
    do
     output ">> $(basename $f) <<" | indent
     output "$(source $f)" | indent | indent
     output "\n"
done


# Cleanup logfile
rm $SCRIPT_DIR"/report.log"
