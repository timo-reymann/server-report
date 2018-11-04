Server-Report
===

## What is this?
An simple, extendable yet powerful reporting tool for your debian-based server.

## Requirements
- Debian based distribuion
- root permissions

## What is in the box?
- Time/Date check 
- Disk usage + warning if its over x %
- RAM Usage 
- Swap Usage
- Available Updates 
- Docker stats - see a snapshot from whats up and running
- Extend with plugins as you like
- Ready for usage with mail reporting and/or cronjobs 

## Installation
### Pre-compiled
```bash
curl -s -L https://cdn.timo-reymann.de/public/server-report/installer.sh > install.sh && chmod +x install.sh && sudo ./install.sh && rm install.sh
```

### If you would like to build and install it your self:
```bash
git clone https://github.com/timo-reymann/server-report.git
cd server-report
chmod +x build.sh
./build.sh
sudo ./dist/installer.sh
```

## Configuration
The configuration for the report tool is under `/opt/server-report/`
After installation there is only `config.sample`, you will need root permissions to copy it, afterwards you can modify it to fit your needs.

Currently the following options are available:

| Key | Value |
| :----  | :---- |
| WARN_DISK_USAGE     | When would you like to get a warn in the report for a disk?     |
| DISKS_TO_CHECK     | Patterns, or devicenames for disk usage check     |

but you can also, and I recommend this, place your configuration for self made plugins there.

## Custom Plugins
Plugins are just simple bash files, placed in `/opt/server-report/plugins`, owned by root.
Currently, the following functions are ready to use:

| Function           |  Parameters/Usage                                                                                                                 |
| :----------------- | :-------------------------------------------------------------------------------------------------------------------------------- |
| get_disk_space     |  Expects device name or pattern and returns the used volume size in percent                                                       |
| output             |  Output some value to the report, use this over echo when possible, because this is included in logfiles and internal methods too |
| get_output         |  Returns the current outputs as string                                                                                            |
| get_memory_value   |  Get memory value from /proc/meminfo by its key                                                                                   |
| format_byte_value  |  Format byte value passed via first parameter and append MB to output                                                             |
| part_heading       |  Print partial heading for part of script                                                                                         |
| indent             |  Format line with indent to regular indentation, in plugins this already done for stdout, so you will produce a "double indent"   |

## Contributing
Have a cool plugin you would like to see enabled by default? - Just submit a pull request and place it in the plugins folder, and i will add it. Currently their is none, but feel free to create it. If you have any further questions, simply open an issue or throw me an mail
