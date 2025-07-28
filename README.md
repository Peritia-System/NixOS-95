# NixOS-95

*A nostalgic Windows 95-inspired NixOS setup with modern pastel vibes.*

This is a **NixOS configuration** designed to evoke the pixel-perfect charm of **Windows 95**, infused with a clean, soft pastel aesthetic. Lightweight, customizable, and perfect for retro lovers or low-spec setups.

---

## 🖥️ System Overview

* **OS**: NixOS
* **DE**: XFCE (customized)
* **GTK Theme**: [Chicago95](https://github.com/grassmunk/Chicago95)
* **Icons & Wallpapers**: [aconfuseddragon](https://aconfuseddragon.itch.io/)


---

## 📁 Directory Overview

<details>
<summary>tree .</summary>

```bash
NixOS-95/
├── flake.nix
├── flake.lock
├── Configurations/
│   └── Hosts/
│       └── Default/
│           ├── configuration.nix
│           ├── hardware-configuration.nix
│           ├── user.nix
│           ├── home/
│           │   ├── home.nix
│           │   ├── desktop.nix
│           │   └── user-packages.nix
│           └── variables/
│               ├── system-vars.nix
│               └── user-vars.nix
├── Modules/
│   ├── Applications/
│   └── System/
├── nixos95
│   ├── dotfiles/
│   ├── core.nix
│   ├── default.nix
│   ├── desktop.nix
│   ├── keybinds.nix
│   ├── taskbar.nix
│   └── theme.nix
├── Ressources/
│   ├── Icons/
│   ├── Images/
│   │   └── Wallpapers/
│   └── Themes/
├── README.md
```

</details>

---

### Wallpaper and Aesthetics

Wallpapers are located in `./Resources/Images/Wallpapers`.  
Some have been lightly edited. Originals were created by [aconfuseddragon](https://aconfuseddragon.itch.io/downloads).  

> I **do not own** any of the icons or wallpapers.  
> If you showcase or redistribute them, **please credit the original artists**.

---

## Installation

> Requires a NixOS install.

1. **Clone the repository**:

   ```bash
   git clone https://github.com/peritia-system/NixOS-95.git NixOS
   cd NixOS
   ```

2. **Regenerate hardware configuration**:

   ```bash
   sudo nixos-generate-config --dir Configurations/Hosts/Default
   ```

3. **Build and switch to the system configuration**:

   ```bash
   sudo nixos-rebuild switch --flake .#default \
        --extra-experimental-features flakes \
        --extra-experimental-features pipe-operators
   ```

4. **Apply user settings with Home Manager**:

   ```bash
   home-manager switch
   ```

### Experimental Features

NixOS-95 relys on multiple experimental nix features. These are:
1. [flakes](https://wiki.nixos.org/wiki/Flakes)
2. [pipe-operators](https://nix.dev/manual/nix/2.26/language/operators#pipe-operators)
They are needed to activate the configuration.

To enable them in your config set:
```nix
nix.settings.experimental-features = [
    "flakes" "pipe-operators"
];
```

### Rebuild Notes

Due to how **Home Manager** and XFCE handle theming, changes may not fully apply on the first attempt.

**For best results:**

1. Rebuild twice
2. Log out and back in after each rebuild

---

## Features

* Pixel-style retro desktop with pastel polish
* Lightweight and XFCE-powered (great for low-spec machines)
* Flake-based configuration with easy updates
* Themed with Chicago95 and matching icon set

---

## Showcase


![Image1](./Ressources/Showcase/vm.png)

<details>
<summary>More Screenshots</summary>

![Image2](./Ressources/Showcase/nyx.png)  
![Image3](./Ressources/Showcase/nixos-ms-surface.png)  
![Image4](./Ressources/Showcase/Games.png)

**Reddit Post:**  
👉 [See the Reddit showcase post](https://www.reddit.com/r/unixporn/comments/1m865np/xfce_win95_themed_rice_nixos95/)


</details>


---

## Final Thoughts

This setup was built for my boyfriend to use during school.
I love how this setup turned out—it's nostalgic and clean, so I wanted to give more people the opportunity to use it.
Hope you enjoy it!
