# ~/.zprofile

# Initialize mise (version manager)
eval "$(mise activate zsh)"

# Add PNPM to PATH if not already present
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac

# Source NVM (commented out — optional)
# source /usr/share/nvm/init-nvm.sh

# (Add more login-specific configuration if needed)

# End of ~/.zprofile
