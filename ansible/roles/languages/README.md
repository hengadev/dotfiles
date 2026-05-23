# languages role

Installs development language runtimes.

**What it does:**
- **Node.js**: installs nvm, then installs and aliases latest LTS
- **Rust**: installs rustup with stable toolchain
- **Go**: downloads latest Go release to `/usr/local/go`
- **Bun**: installs via the official install script

All installations are idempotent — tools are skipped if already present.
