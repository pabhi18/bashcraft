#!/bin/bash

for file in ~/Downloads/*; do
    if [[ -d "$file" ]]; then 
        continue
    fi

    if [[ $file == *.mp3 || $file == *.wav ]]; then
        mkdir -p ~/Downloads/music
        mv "$file" ~/Downloads/music/
    elif [[ $file == *.jpg || $file == *.jpeg || $file == *.gif || $file == *.png ]]; then
        mkdir -p ~/Downloads/images
        mv "$file" ~/Downloads/images/
    elif [[ $file == *.pdf ]]; then 
        mkdir -p ~/Downloads/pdf
        mv "$file" ~/Downloads/pdf/
    elif [[ $file == *.mp4 || $file == *.mov ]]; then
        mkdir -p ~/Downloads/videos
        mv "$file" ~/Downloads/videos/
    elif [[ $file == *.zip || $file == *.tar.* ]]; then
        mkdir -p ~/Downloads/zip-files
        mv "$file" ~/Downloads/zip-files/
    elif [[ $file == *.csv || $file == *.ods || $file == *.xlsx || $file == *.txt || $file == *.docx || $file == *.doc ]]; then   
        mkdir -p ~/Downloads/docs
        mv "$file" ~/Downloads/docs/
    elif [[ $file == *.py || $file == *.ipynb || $file == *.db ]]; then
        mkdir -p ~/Downloads/python
        mv "$file" ~/Downloads/python/
    else 
        mkdir -p ~/Downloads/others
        mv "$file" ~/Downloads/others/
    fi
done

