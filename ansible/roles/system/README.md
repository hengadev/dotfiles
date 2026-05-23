# system role

Installs base system packages and CLI tools.

**What it does:**
- Updates apt cache
- Installs packages from `system_packages` (defined in `vars/packages.yml`)
- Downloads and installs lazygit and lazydocker from GitHub releases

**Requires:** `become: true` (sudo)
