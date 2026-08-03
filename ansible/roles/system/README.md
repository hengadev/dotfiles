# system role

Installs base system packages and CLI tools.

**What it does:**
- Updates apt cache
- Installs packages from `system_packages` (defined in `vars/packages.yml`)
- Installs wezterm (via COPR on Fedora/RHEL, via apt.fury.io repo on Debian/Ubuntu)
- Installs Brave browser via the official install script
- Downloads and installs lazygit and lazydocker from GitHub releases

**Requires:** `become: true` (sudo)
