#!/usr/bin/env python3
"""
Enable or disable greyscale color profile on systems with Nvidia graphics card.

This script enables or disables a greyscale or color profile for a system using
a Nvidia graphics card. This encourages good health for daily computing usage
and counteracts against the psychology of color.

https://blog.mozilla.org/internetcitizen/2018/02/13/grayscale/

The script simplifies the user interface to making this change.
"""

import argparse
import re
import subprocess
import sys

__author__ = 'Justin W. Flory'
__license__ = 'Mozilla Public License 2.0'


def retrieve():
    """
    Retrieves current digital vibrance value set by nvidia driver.

    First, it queries setting value on the HDMI-0 display (this is hard-coded
    now, but should be self-detectable. Then, the output of the command is
    parsed and split with regex to extract the actual config value.
    """
    vibrance_readout = []

    cmd = ['nvidia-settings', '-q', '[DPY:HDMI-0]/DigitalVibrance']
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    for line in proc.stdout.readlines():
        if "Attribute 'DigitalVibrance'".encode('utf-8') in line:
            vibrance_readout = re.split('[; |, |. |\*|\n]', str(line))
            print('Current color profile: {}'.format(vibrance_readout[5]))
            print('0 means default color display.',
                  '\n-1024 means greyscale display.')


def set_color():
    """Set display profile to default color profile (via nvidia-settings)."""
    subprocess.call(
        ['nvidia-settings', '-a', '[DPY:HDMI-0]/DigitalVibrance=0'])


def set_greyscale():
    """Set display profile to greyscale profile (via nvidia-settings)."""
    subprocess.call(
        ['nvidia-settings', '-a', '[DPY:HDMI-0]/DigitalVibrance=-1024'])


def main():
    """Main function, initializes class."""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--color', '-c', action='store_true',
        help='enable default color profile (0)')
    parser.add_argument(
        '--greyscale', '-g', action='store_true',
        help='enable greyscale profile (-1024)')
    parser.add_argument(
        '--retrieve', '-r', action='store_true',
        help='retrieve existing color profile value')
    args = parser.parse_args()

    if len(sys.argv) > 2:
        raise SystemExit(
            "Too many arguments. Use '-h' argument for usage help.")

    if args.retrieve:
        retrieve()
    if args.color:
        set_color()
    if args.greyscale:
        set_greyscale()


if __name__ == '__main__':
    main()
