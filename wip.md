# WORK IN PROGRESS

___

## Install Required Tools

```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
  brew upgrade git         || brew install git
  brew upgrade gh          || brew install gh
  brew upgrade pyenv       || brew install pyenv
  brew upgrade direnv      || brew install direnv

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt-get update      || sudo apt-get install -y git gh direnv

else

fi
```
