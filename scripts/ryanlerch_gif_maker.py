#!/usr/bin/python3
#
# Run the script, select the area you want to screencast, then stop the script
# by closing the window. The video should output into ~/Videos/screencast.webm
#
# Originally written by Ryan Lerch <rlerch@redhat.com>.
#

import gi
import dbus
# import signal
import os

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
# from subprocess import call


class MyWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Screencaster")

        self.button = Gtk.Button(label="Finish Screencast")
        self.button.connect("clicked", Gtk.main_quit)
        self.add(self.button)


bus = dbus.SessionBus()
screenshot_object = bus.get_object(
    'org.gnome.Screenshot', '/org/gnome/Screenshot')
screenshot_interface = dbus.Interface(
    screenshot_object, 'org.gnome.Screenshot')
# screencast_object = bus.get_object(
#     'org.gnome.Screencast', '/org/gnome/Screencast')
# screencast_interface = dbus.Interface(
#     screencast_object, 'org.gnome.Screencast')

selectedarea = screenshot_interface.SelectArea()

print(
    "byzanz-record -x " + str(selectedarea[0])
    + " -y " + str(selectedarea[1])
    + " -w" + str(selectedarea[2])
    + " -h " + str(selectedarea[3])
    + " -d 300 screencast.gif")
os.system(
    "byzanz-record -x " + str(selectedarea[0])
    + " -y " + str(selectedarea[1])
    + " -w " + str(selectedarea[2])
    + " -h " + str(selectedarea[3])
    + " -d 300 screencast.gif")
print(selectedarea)

# subprocess.call(["xdg-open", filename[1]])
