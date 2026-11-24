# lsfg-vk for ZenOS

Nix packaging for the unmodified [lsfg-vk 2.0.0](https://lsfg-vk.dev/) release by PancakeTAS.
Includes the Vulkan layer, command-line tools, and upstream Qt configuration interface.
Upstream code remains licensed CC BY-NC-ND 4.0. This repository does not include
Lossless Scaling's proprietary files: buy and install Lossless Scaling on Steam
and select its `lsfg-vk` beta branch.

Enable the package through ZenPkgs. Configure per-game profiles in
`$XDG_CONFIG_HOME/lsfg-vk/conf.toml` (or `~/.config/lsfg-vk/conf.toml`).
Keep `active_in` restricted to the game executable, especially when using Gamescope,
so frame generation is applied to the game's frames rather than the compositor.

The managed user profile exports `share/vulkan/implicit_layer.d`. Steam games may
need that directory appended to `VK_ADD_IMPLICIT_LAYER_PATH` if Steam was started
before installation or its runtime does not inherit the profile's XDG data path.
Preserve existing entries, including Gamescope's WSI layer.
