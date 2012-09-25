oh-my-zsh-treichler-theme
=========================

Screenshot
----------

![Screenshot](http://github.com/dtreichler/oh-my-zsh-treichler-theme/raw/master/screenshot.png)

Installation
------------

1. Clone this repository
2. Create a symlink    
    `cd oh-my-zsh-treichler-theme`    
    `ln -s treichler.zsh-theme ~/.oh-my-zsh/themes`    
3. Configure your `.zshrc`
    ZSH_THEME="treichler"

Features
--------

* Supports `virtualenv` without shifting prompt
* Git repo status
* No unicode characters for those without uncode support in their terminal
* Trimmed cwd for long paths

Configuration
-------------
It is possible to modify the colors in the prompt by setting variables in your `.zshrc` file.

* `$PR_PATHCOLOR` --> cwd
* `$PR_USERCOLOR` --> user
* `$PR_HOSTCOLOR` --> hostname
* `$PR_ENVCOLOR` --> virtualenv

Variables are easily set with the `fg` variable, like so

    export PR_HOSTCOLOR=$fg[green]

Note that case matters for the colors. Possible values are red, green, yellow, blue, magenta, cyan, white and grey.

Requirements
------------

* `zsh`
* `oh-my-zsh`

License
-------
```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                    Version 2, December 2004 

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO. 
```
