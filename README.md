To install:

0. Install all required software and update settings (check Obsidian notes)
1. `cd .dotfiles/frixaco`
2. `stow --adopt --simulate --verbose --no-folding . -t $HOME` (remove `--simulate` flag to actually apply changes)

TODO:

- [ ] Fix duplicate diagnostics in Neovim
- [ ] Add video demo of my setup
- [ ] SSH keys setup (1Passwod seems to work)
- [ ] AWS credentials setup
- [ ] Easier setup between macOS, Windows, Linux

<!-- ### Yabai -->
<!---->
<!-- Updating from HEAD: -->
<!---->
<!-- ```fish -->
<!-- export YABAI_CERT= -->
<!-- yabai --stop-service -->
<!-- yabai --uninstall-service -->
<!-- brew reinstall koekeishiya/formulae/yabai -->
<!-- set -x YABAI_CERT yabai-cert -->
<!-- codesign -fs "$YABAI_CERT" (brew --prefix yabai)/bin/yabai -->
<!-- echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai -->
<!-- yabai --start-service -->
<!-- ``` -->
<!---->
<!-- For installing: -->
<!---->
<!-- ```fish -->
<!-- codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai -->
<!-- ``` -->
