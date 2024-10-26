#!/bin/env bash

source scripts/helper.sh

install_ollama()
{
    header "Download Ollama" 

    # curl -fsSL https://ollama.com/install.sh | sh
    download https://ollama.com/install.sh
    
    cd $HOME && sh ./install.sh

    success
}

main () {
  install_ollama
}

main
