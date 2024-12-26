plugins = zsh-autosuggestions

all: install clone setting
	@echo "\nWelcome install ZSH\n"

clone:
	@if command -v $(shell ls ~.oh-my-zsh) >/dev/null 2>&1; then \
		echo "oh-my-zsh is already installed."; \
	else \
		curl -L http://install.ohmyz.sh | sh; \
	fi
	@echo "Clone zsh-autosuggestions\n"
	@sudo apt install git
	@rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	@git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

setting: zsh-autosuggestions 

install:
	@if command -v zsh >/dev/null 2>&1; then \
		echo "Zsh is already installed."; \
	else \
		sudo apt-get install zsh -y; \
		echo "Zsh installed at: $(shell which zsh)"; \
	fi; \
	if [ -x "$(shell which zsh)" ]; then \
		chsh -s $(shell which zsh); \
		echo "Setting ZSH for default Telminal"; \
	else \
		echo "Error: Zsh installation failed. Cannot change shell."; \
	fi

zsh-autosuggestions:
	@echo "Installing plugins: $(plugins)"
	@sudo echo "ZSH_THEME=\"bira\"\n" >> ~/.zshrc
	@sudo echo "source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\n" >> ~/.zshrc

clear:
	@sudo apt remove zsh
	@rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	@rm -rf ~/.oh-my-zsh
	@rm -rf ~/.zshrc.pre-oh-my-zsh
	@rm -rf ~/.zshrc	
	@sudo apt autoremove