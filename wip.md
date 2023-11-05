# WORK IN PROGRESS

___

## Modification Color

Few problemes with the inicode.
Try to use the flag `-e` to echo for the interpretation of the backslash.


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

- pyenv for linux
- what to do for Win users ?

## Modification of the README

1. Modifiaction of few parts of the doc ✅
    - Change `Usage` to `How to Install` -> Create the command to install it
    - Change `How to Run` and explain the alias create during the setup
2. Rearrange block order
3. Be more explicit for the usage
    - It's just for python right now
