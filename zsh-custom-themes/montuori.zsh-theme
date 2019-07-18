# -*- mode: shell-script -*-
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1="${return_code}"

magenta=%{$fg[white]%}
red=%{$fg[red]%}
cyan=%{$fg[cyan]%}
reset=%{$reset_color%}

if [[ $TERM == 'eterm-color' ]]; then 
    PROMPT="%m %2~ : "
elif [[ $TERM == 'emacs' ]]; then
    PROMPT="%m: "
else
    PROMPT='$magenta%m$red∙$magenta%2~$(git_prompt_info)$red ⇢ $reset'
    ZSH_THEME_GIT_PROMPT_PREFIX="$red∙$magenta⟨"
    ZSH_THEME_GIT_PROMPT_SUFFIX="⟩$reset"
    ZSH_THEME_GIT_PROMPT_DIRTY="$cyan∙$magenta"
fi

