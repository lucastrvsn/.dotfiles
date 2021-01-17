> My arch linux installation script.

# Tips (sway)

## Configure keyboard layout

To us-international, change `sway` config file

```
input * {
  xkb_layout us
  xkb_variant intl
}
```

## Configure touchpad, keyboard and etc

```
input "type:touchpad" {
  tap enabled
  natural_scroll enabled
}
```

## Configure GTK3 theme

Update `sway` config using:

```
set $gnome-schema org.gnome.desktop.interface

exec_always {
  gsettings set $gnome-schema gtk-theme 'Pop-dark'
  gsettings set $gnome-schema icon-theme 'Pop'
  gsettings set $gnome-schema cursor-theme 'OpenZone_White'
  gsettings set $gnome-schema font-name 'Noto Sans 11'
}
```
