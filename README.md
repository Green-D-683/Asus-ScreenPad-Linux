# Asus-ScreenPad-Linux

This repository exists to provide tools for using an Asus Screenpad on Linux. 

This is a 1080x2160 rotated display on the touchpad of select Asus laptops. 

The following components are included:

- <a href="./toggle-screenpad.sh"> toggle-screenpad.sh </a>
  - A script for enabling and disabling the screenpad on devices running KDE Plasma 6 with Wayland.
    - Requires 'kscreen-doctor' tool (plasma 6 version) available in `$path`, but may be adapted to use other tools, such as 'wlr-randr'.
  - Tested on 
    - Asus Zenbook Pro 15 (ux535)
- <a href="./toggle-screenpad-plasma5.sh"> toggle-screenpad-plasma5.sh </a>
  - A script for enabling and disabling the screenpad on devices running KDE Plasma 5 with Wayland.
    - Requires 'kscreen-doctor' tool (plasma 5 version) available in `$path`, but may be adapted to use other tools, such as 'wlr-randr'.
  - Tested on 
    - Asus Zenbook Pro 15 (ux535)

