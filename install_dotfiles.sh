#!/bin/bash

# Set the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Create symlinks
create_symlinks() {
    echo "Creating symlinks..."
    ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
    ln -sf $DOTFILES_DIR/.p10k.zsh $HOME/.p10k.zsh
    # Add more symlinks as needed
}

# Install Zsh if not already installed
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        echo "Installing Zsh..."
        apt update && apt install -y zsh
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # Move the newly created .zshrc to .zshrc.oh-my-zsh
        mv $HOME/.zshrc $HOME/.zshrc.oh-my-zsh
    fi
}

# Install Powerlevel10k theme
install_powerlevel10k() {
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

# Install Oh My Zsh plugins
install_oh_my_zsh_plugins() {
    echo "Installing Oh My Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # Add more plugin installations as needed
}

# Install additional tools
install_additional_tools() {
    echo "Installing additional tools..."
    
    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    source $HOME/.fzf/install --all
    
    # Install fzf-git.sh
    git clone https://github.com/junegunn/fzf-git.sh.git $HOME/fzf-git.sh
    
    # Install thefuck
    pip install thefuck
    
    # Install zoxide
    curl -sS https://webinstall.dev/zoxide | bash

    # Install eza
    apt install -y gpg
    mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
    chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    apt update
    apt install -y eza
}

# Configure additional tools
configure_additional_tools() {
    echo "Configuring additional tools..."
    
    # Configure fzf
    echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> $HOME/.zshrc
    
    # Configure fzf-git.sh
    echo 'source ~/fzf-git.sh/fzf-git.sh' >> $HOME/.zshrc
    
    # Configure thefuck
    echo 'eval $(thefuck --alias)' >> $HOME/.zshrc
    
    # Configure zoxide
    echo 'eval "$(zoxide init zsh)"' >> $HOME/.zshrc
}

# Main installation process
main() {
    install_zsh
    install_oh_my_zsh
    install_powerlevel10k
    install_oh_my_zsh_plugins
    install_additional_tools
    create_symlinks
    # configure_additional_tools

    echo "Dotfiles installation complete!"
    echo "Please restart your shell or run 'source ~/.zshrc' to apply changes."
    echo "Then run 'p10k configure' to set up Powerlevel10k if it doesn't start automatically."
}

# Run the main installation process
main