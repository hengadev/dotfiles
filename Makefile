PLAYBOOK  = ansible/bootstrap.yml
INVENTORY = ansible/inventory
ANSIBLE   = ansible-playbook

.PHONY: bootstrap dotfiles shell neovim languages gnome check verbose help

bootstrap: ## Full bootstrap with all roles
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --ask-become-pass

dotfiles: ## Sync dotfiles only
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --tags dotfiles

shell: ## Shell setup only (zsh, starship)
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --tags shell --ask-become-pass

neovim: ## Neovim setup only
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --tags neovim --ask-become-pass

languages: ## Language runtimes only (node, rust, go, bun)
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --tags languages

gnome: ## GNOME settings only
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --tags gnome

check: ## Dry-run mode (no changes made)
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) --check --ask-become-pass

verbose: ## Full run with verbose output
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) -vvv --ask-become-pass

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
