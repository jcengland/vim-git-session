# Vim Git Session

Is a quick hack to use Vim sessions that are name automaticaly and save with the following name:

`git branch`-`git repo name including organization or username`-session.vim

For instance: "master-rnaveiras-vim-git-session-session.vim"

This sessions are saved at ~/.vim/sessions

The plugin map `<leader>s` to save the session or you can call the function "SaveCurrentSession()"

You can autosave your session by setting somewhere in your vimrc the global variable `g:session_autosave` to "yes":

    let g:session_autosave = 'yes'

To open a session just run `vim -S session-name.vim` or type `<leader>o` inside vim. You can also call the function "OpenCurrentSession()"
