# PROMPT
PS1='\[\e[90m\][\A] \[\e[1;32m\]\u\[\e[0;36m\]@\h \[\e[1;33m\]\w\[\e[0;33m\] $ \[\e[0m\]'

# Загружает настройки цветов для ls/lsd из файла ~/.dircolors
eval "$(dircolors -b ~/.dircolors)"

# Добавляем директорию с пользовательскими бинарниками
export PATH="$HOME/.local/bin:$PATH"

# Включаем автоматический переход в директории при вводе их имени
shopt -s autocd

# ======================================================
#                       АЛИАСЫ
# ======================================================
# Навигация
alias ..='cd ..'

# Цветной ls через lsd
alias ls='lsd -A'
alias ll='lsd -Al'
alias lt='ls --tree'

# Быстрый доступ к bashrc и .config
alias bashrc='nvim ~/.bashrc && source ~/.bashrc'
alias config='cd ~/.config'

# ======================================================
#                     ИСТОРИЯ КОМАНД
# ======================================================
# Добавление команд в историю, не затирая предыдущие
shopt -s histappend

# Размер истории
export HISTSIZE=5000          # команды в текущей сессии
export HISTFILESIZE=10000     # размер файла истории

# Игнорируем дубликаты и простые команды
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="ls:ll:lt:pwd:exit:cd"

# Сохраняем историю сразу после каждой команды
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
