set -gx GEM_HOME (ruby -e 'print Gem.user_dir')
set -gx N_PREFIX $HOME/.n
set -gx PATH $HOME/.n/bin $HOME/Bin $HOME/.local/bin (ruby -e 'print Gem.user_dir')/bin $PATH

function code
  command code $argv --disable-gpu
end
