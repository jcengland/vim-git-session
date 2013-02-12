# Vim Git Session

Is a quick hack to use Vim sessions that are name automaticaly and save with the following name:

`git branch`-`git repo name including organization or username`-session.vim

For instance: "master-rnaveiras-vim-git-session-session.vim"

This sessions are saved at ~/.vim/sessions

The plugin map <leader>s to save the session or you can call the function "SaveCurrentSession()"

For open a session just run `vim -S session-name.vim`
