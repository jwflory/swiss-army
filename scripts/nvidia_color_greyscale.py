#!/usr/bin/env python3
"""
Enable or disable a greyscale or color profile for your Nvidia graphics card.
The purpose of doing this is to encourage good health with daily computing
usage. The script simplifies the user interface to making this change.
"""

import argparse, re, subprocess, sys

__author__ = "Justin W. Flory"
__license__ = "Mozilla Public License 2.0"

def retrieve():
    """
    Retrieves current digital vibrance value set by nvidia driver

    First, it queries setting value on the HDMI-0 display (this is hard-coded
    now, but should be self-detectable. Then, the output of the command is
    parsed and split with regex to extract the actual config value.
    """
    vibrance_readout = []
    
    cmd = ["nvidia-settings", "-q", "[DPY:HDMI-0]/DigitalVibrance"]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    for line in proc.stdout.readlines():
        if "Attribute 'DigitalVibrance'".encode('utf-8') in line:
            vibrance_readout = re.split('[; |, |. |\*|\n]', str(line))
            print("Current color profile: {}".format(vibrance_readout[5]))
            print("0 means default color display.",
                  "\n-1024 means greyscale display.")

def set_color():
    """
    Sets display profile to default color profile (via nvidia-settings)
    """
    subprocess.call(["nvidia-settings", "-a", "[DPY:HDMI-0]/DigitalVibrance=0"])

def set_greyscale():
    """
    Sets display profile to greyscale profile (via nvidia-settings)
    """
    subprocess.call(["nvidia-settings", "-a",
                    "[DPY:HDMI-0]/DigitalVibrance=-1024"])

def main():
    """
    Main function, initializes class.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("--color", "-c", help="enable default color profile (0)",
                        action="store_true")
    parser.add_argument("--greyscale", "-g",
                        help="enable greyscale profile (-1024)",
                        action="store_true")
    parser.add_argument("--retrieve", "-r",
                        help="retrieve existing color profile value",
                        action="store_true")
    args = parser.parse_args()
    
    if len(sys.argv) > 2:
        print("Too many arguments specified. Please run with -h flag for help.")
        sys.exit(1)

    if args.retrieve:
        retrieve()
    if args.color:
        set_color()
    if args.greyscale:
        set_greyscale()

main()
