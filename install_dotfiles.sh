#!/bin/bash

# Set the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Create symlinks
create_symlinks() {
    echo "Creating symlinks..."
    ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
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

# Install Oh My Zsh plugins
install_oh_my_zsh_plugins() {
    echo "Installing Oh My Zsh plugins..."
    # Add your desired plugins here
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # Add more plugin installations as needed
}

# Main installation process
main() {
    install_zsh
    install_oh_my_zsh
    install_oh_my_zsh_plugins
    create_symlinks

    echo "Dotfiles installation complete!"
    echo "Please restart your shell or run 'source ~/.zshrc' to apply changes."
}

# Run the main installation process
main