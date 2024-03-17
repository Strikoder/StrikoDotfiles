# StrikoDotfiles Installation Guide

Quickly set up your environment using my personal dotfiles. Follow the steps below to get started.

## Step 1: Install Git
- For **Debian/Ubuntu/Kali**:
  ```bash
  sudo apt update && sudo apt install git
  ```
- For **Fedora**:
  ```bash
  sudo dnf install git
  ```
- For **Arch BTW**:
  ```bash
  sudo pacman -Sy git
  ```
- For **macOS/ Windows**:
  GFYS
  
## Step 2: Clone and Install Dotfiles

```bash
git clone git@github.com:strikoder/StrikoDotfiles.git --recursive
cd StrikoDotfiles && ./install
```

This will set up your environment according to the configurations specified in my dotfiles. 
The `--recursive` option ensures that any submodules are also cloned.

## step 3: programs installation

in progress


