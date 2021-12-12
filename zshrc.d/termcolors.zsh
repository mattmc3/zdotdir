# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors
# https://chrisyeh96.github.io/2020/03/28/terminal-colors.html
reset_color="\e[00m"
typeset -gA fg_colors bg_colors color_fx
color_fx=(
  bold       "\e[01m"
  dim        "\e[02m"
  italic     "\e[03m"
  underline  "\e[04m"
  reverse    "\e[07m"
)
fg_colors=(
  black      "\e[30m"
  red        "\e[31m"
  green      "\e[32m"
  yellow     "\e[33m"
  blue       "\e[34m"
  magenta    "\e[35m"
  cyan       "\e[36m"
  white      "\e[37m"
  brblack    "\e[90m"
  brred      "\e[91m"
  brgreen    "\e[92m"
  bryellow   "\e[93m"
  brblue     "\e[94m"
  brmagenta  "\e[95m"
  brcyan     "\e[96m"
  brwhite    "\e[97m"
)
bg_colors=(
  black      "\e[40m"
  red        "\e[41m"
  green      "\e[42m"
  yellow     "\e[43m"
  blue       "\e[44m"
  magenta    "\e[45m"
  cyan       "\e[46m"
  white      "\e[47m"
  brblack    "\e[100m"
  brred      "\e[101m"
  brgreen    "\e[102m"
  bryellow   "\e[103m"
  brblue     "\e[104m"
  brmagenta  "\e[105m"
  brcyan     "\e[106m"
  brwhite    "\e[107m"
)

function showcolors() {
  local color
  for color in ${(ok)fg_colors}; do
    echo "${fg_colors[$color]}foreground $color${reset_color}"
  done
  for color in ${(ok)bg_colors}; do
    echo "${fg_colors[white]}${bg_colors[$color]}background ${fg_colors[black]}$color${reset_color}"
  done
  for effect in ${(ok)color_fx}; do
    echo "${color_fx[$effect]}$effect${reset_color}"
  done
}
