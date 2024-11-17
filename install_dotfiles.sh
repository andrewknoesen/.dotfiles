#!/bin/bash

# Set the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Create symlinks
create_symlinks() {
    echo "Creating symlinks..."
    ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
    ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
    # Add more symlinks as needed
}

# Install Zsh if not already installed
install_zsh() {
    if [ ! -f /bin/zsh ]; then
        echo "Installing Zsh..."
        apt update
        apt install -y zsh
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Importing .zshrc config"
        cat ~/.zshrc.pre-oh-my-zsh >> ~/.zshrc
    fi
}

# Install Vim plugins
install_vim_plugins() {
    echo "Installing Vim plugins..."
    vim +PlugInstall +qall
}

# Main installation process
main() {
    create_symlinks
    install_zsh
    install_oh_my_zsh
    install_vim_plugins
    
    echo "Dotfiles installation complete!"
    echo "Please restart your shell or run 'source ~/.zshrc' to apply changes."
}

# Run the main installation process
main
