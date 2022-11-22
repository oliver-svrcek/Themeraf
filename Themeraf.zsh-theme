# Themeraf theme
# by Oliver Svrcek

SEPARATOR="%{$FG[235]%} · "
CLEAR="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="${SEPARATOR}${CLEAR}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${CLEAR}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[160]%} ●"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%} ●"

export VIRTUAL_ENV_DISABLE_PROMPT=1

local git_info='$(git_prompt_info)'
local virtualenv_info='$(virtual_enviroment_part)'
local prompt_char='$(end_part)'


function virtual_enviroment_part() {
    if [ $VIRTUAL_ENV ]; then
        local venv_format="%{$FG[032]%}"
        local venv_content="$(basename $VIRTUAL_ENV)"
        echo "${CLEAR}${venv_format}${venv_content}${CLEAR}${SEPARATOR}${CLEAR}"
    fi
}

function start_part() {
    local format="%{$FG[255]%}"
    local end_content="┍ "
    echo "${format}${start_content}${CLEAR}${format}${end_content}${CLEAR}$(virtual_enviroment_part)${CLEAR}"
}

function username_part() {
    local format="$terminfo[bold]$FG[226]"
    local content="%n"
    echo "${format}${content}${CLEAR}"
}

function working_directory_part() {
    local prefix_format="%{$FG[245]%}"
    local content_format="%{$FG[255]%}"
    local prefix=""
    local content="%2d"

    if [[ $(pwd | cut -d\/ -f 4) != "" ]]; then
        local prefix="...${CLEAR}/"
    fi

    echo "${SEPARATOR}${CLEAR}${prefix_format}${prefix}${CLEAR}${format}${content}${CLEAR}"
}

function time_part() {
    local format="%{$FG[255]%}"
    local content="%*"
    echo "${SEPARATOR}${CLEAR}${format}${content}${CLEAR}"
}

function exit_status_part() {
    local format_zero="%{$FG[255]%}"
    local format_other="%{$FG[214]%}"
    local content="%(?.${format_zero}%?.${format_other}%?)"
    echo "${SEPARATOR}${CLEAR}${content}${CLEAR}"
}

function end_part() {
    local format="%{$FG[255]%}"
    local content="┕ "
    echo "${format}${content}${CLEAR}"
}

function rng_easter_egg_part() {
    if [ $(seq 1000 | sort -R | head -1) -eq 420 ]; then
        echo "42 72 75 68 ━ "
    fi
}

PROMPT="\$(start_part)\$(username_part)\$(working_directory_part)\$(git_prompt_info)\$(time_part)\$(exit_status_part)
\$(end_part)\$(rng_easter_egg_part)"

