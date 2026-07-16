# dotfiles

macOS setup — tiling window manager, status bar, terminal, prompt.

## Stack

- **AeroSpace** — tiling WM (i3-style, Option as modifier)
- **SketchyBar** — status bar with per-workspace app icons
- **JankyBorders** — active window highlight
- **kitty** — terminal
- **Starship** — prompt
- **zsh** — autosuggestions + syntax highlighting

Theme: duckbones, amber accent (`#e3d18a`).

## Install

Install the tools:

```
brew tap FelixKratz/formulae
brew install --cask nikitabobko/tap/aerospace
brew install sketchybar borders starship zsh-autosuggestions zsh-syntax-highlighting
brew install --cask font-jetbrains-mono-nerd-font
```

Clone and symlink:

```
git clone <repo-url> ~/dotfiles

ln -s ~/dotfiles/zshrc                ~/.zshrc
ln -s ~/dotfiles/aerospace.toml       ~/.aerospace.toml
ln -s ~/dotfiles/config/kitty         ~/.config/kitty
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/config/sketchybar    ~/.config/sketchybar
ln -s ~/dotfiles/config/borders       ~/.config/borders
ln -s ~/dotfiles/config/aerospace     ~/.config/aerospace
```

Start the services:

```
brew services start sketchybar
brew services start borders
aerospace reload-config
```

## macOS setup

- Grant **AeroSpace** Accessibility permission (System Settings > Privacy & Security)
- Collapse to a single macOS desktop; disable "Automatically rearrange Spaces"
- Disable Mission Control's "Move left/right a space" shortcuts
- Hide the menu bar: Control Center > "Automatically hide and show the menu bar" > Always
- Hide the Dock permanently:

```
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 1000
killall Dock
```

## Keybinds

| Key | Action |
|-----|--------|
| `alt + enter` | new kitty |
| `alt + w` | new Firefox window |
| `alt + e` | Finder |
| `alt + q` | quit focused app |
| `alt + 1-5` | switch workspace |
| `alt + shift + 1-5` | move window to workspace |
| `alt + arrows` | focus window |
| `alt + shift + arrows` | move window |
| `alt + shift + space` | toggle float/tile |
| `alt + shift + c` | reload AeroSpace config |

## Notes

- **Firefox needs `MOZ_DISABLE_SAFE_MODE_KEY=1` on launch.** Option is the macOS
  Troubleshoot Mode trigger, and the launch bind is Option+W — without this,
  Firefox opens in Troubleshoot Mode every time.
- `alt + q` closes all Firefox windows at once; Firefox is single-process.
- `outer.top` in `aerospace.toml` controls clearance under SketchyBar.
- SketchyBar app icons need `icon_map.sh` from the sketchybar-app-font release.
