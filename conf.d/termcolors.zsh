# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors
# https://chrisyeh96.github.io/2020/03/28/terminal-colors.html
reset_color="\e[00m"
typeset -gA fg_colors bg_colors color_fx
color_fx=(
  normal     "\e[00m"
  bold       "\e[01m"
  dim        "\e[02m"
  italic     "\e[03m"
  underline  "\e[04m"
  reverse    "\e[07m"
)
fg_colors=(
  normal     "\e[00m"
  black      "\e[30m"    brblack    "\e[90m"
  red        "\e[31m"    brred      "\e[91m"
  green      "\e[32m"    brgreen    "\e[92m"
  yellow     "\e[33m"    bryellow   "\e[93m"
  blue       "\e[34m"    brblue     "\e[94m"
  magenta    "\e[35m"    brmagenta  "\e[95m"
  cyan       "\e[36m"    brcyan     "\e[96m"
  white      "\e[37m"    brwhite    "\e[97m"
)
bg_colors=(
  normal     "\e[00m"
  black      "\e[40m"    brblack    "\e[100m"
  red        "\e[41m"    brred      "\e[101m"
  green      "\e[42m"    brgreen    "\e[102m"
  yellow     "\e[43m"    bryellow   "\e[103m"
  blue       "\e[44m"    brblue     "\e[104m"
  magenta    "\e[45m"    brmagenta  "\e[105m"
  cyan       "\e[46m"    brcyan     "\e[106m"
  white      "\e[47m"    brwhite    "\e[107m"
)

function showcolors() {
  local color effect
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
