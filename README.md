# i3 & Arch Rice

My personal dotfiles for Arch + i3 setup

## Usage

After copying the git repo, simply run `install.sh desktop/x220`. Any 
conflicts that are found will be copied to `~/df_backup` so that you can 
rollback without any worry.

_Note_: install.sh requires `stow` to be installed in your system.

## Programs used

| **Program** | **Description**                                                                   |
| -------     | -----------                                                                       |
| i3-gaps     | WM of my choice                                                                   |
| polybar     | status bar of my choice                                                           |
| rofi        | application search software of my choice                                          |
| rofi-emoji  | An emoji selector plugin for Rofi that copies the selected emoji to the clipboard |
| maim        | screenshot tool of my choice                                                      |
| zsh         | shell of my choice                                                                |
| vim         | text editor of my choice (dotfile still WIP)                                      |
| rtv         | CLI reddit browser. Require Python, mailcap, xclip, and urlview to work properly  |
| dunst       | notification software of my choice                                                |
| fcitx       | input method framework of my choice                                               |
| fzf         | commandline fuzzy finder                                                          |
| rg          | AKA ripgrep. Used with fzf                                                        |

## TODOs

- [x] Complete i3 config file
- [x] Complete polybar config file 
- [x] Setup rtv
- [ ] Complete zsh config file 
- [x] Config qutebrowser
- [x] Rice rofi
- [ ] Complete vimrc
- [x] Install ranger and modify config file 
- [ ] Talk about zsm interactive cd
- [x] Add fzf and ripgrep to the list of Program Used
- [x] Install script (maybe also install the programs used in the future?)
- [ ] Uninstall script
