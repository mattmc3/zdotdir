# Zsh Options

Set options with `setopt`, unset with `unsetopt`. Options can take a `NO_` prefix as
well (eg: `setopt NO_BEEP` is the same as `unsetopt BEEP`). You can view set options via
the `set -o` command. You can see only enabled options with `set -o | grep 'on$'`.

Asterisk (\*) indicates the option is on by default for native zsh.

| Option                   | Short Description                       |
| ------------------------ | --------------------------------------- |
| \*[ALIASES]              | Expand aliases                          |
| [ALL_EXPORT]             | Export all variables to environment     |
| \*[ALWAYS_LAST_PROMPT]   | Completion lists after prompt           |
| [ALWAYS_TO_END]          | On completion go to end of word         |
| \*[APPEND_HISTORY]       | History appends to existing file        |
| [AUTO_CD]                | Directory as command does `cd`          |
| [AUTO_CONTINUE]          | Jobs are continued when `disown`ed      |
| \*[AUTO_LIST]            | List ambiguous completions              |
| \*[AUTO_MENU]            | Menu complete after two tabs            |
| [AUTO_NAME_DIRS]         | Variables always can be %~ abbrevs      |
| \*[AUTO_PARAM_KEYS]      | Magic completion for parameters         |
| \*[AUTO_PARAM_SLASH]     | `$dirname` completes with `/`           |
| [AUTO_PUSHD]             | `cd` uses directory stack too           |
| \*[AUTO_REMOVE_SLASH]    | Trailing `/` in completion removed      |
| [AUTO_RESUME]            | `cmd` can resume job `%cmd`             |
| \*[BAD_PATTERN]          | Errors on pattern syntax; else literal  |
| \*[BANG_HIST]            | `!` style history allowed               |
| \*[BARE_GLOB_QUAL]       | Glob qualifiers with bare parens        |
| [BASH_AUTO_LIST]         | List completions on second tab          |
| \*[BEEP]                 | Beep on all errors                      |
| \*[BG_NICE]              | Background jobs at lower priority       |
| [BRACE_CCL]              | `X{ab}` expands to `Xa` `Xb`            |
| [BSD_ECHO]               | No echo escapes unless `-e` given       |
| \*[CASE_GLOB]            | Glob case sensitively                   |
| [C_BASES]                | Output hexadecimal with `0x`            |
| [CDABLE_VARS]            | `cd var` works if `$var` is directory   |
| [CHASE_DOTS]             | Resolve `..` in `cd`                    |
| [CHASE_LINKS]            | Resolve symbolic links in `cd`          |
| \*[CHECK_JOBS]           | Check jobs before exiting shell         |
| \*[CLOBBER]              | Allow redirections to overwrite         |
| [COMPLETE_ALIASES]       | Completion uses unexpanded aliases      |
| [COMPLETE_IN_WORD]       | Completion works inside words           |
| [CORRECT]                | Correct spelling of commands            |
| [CORRECT_ALL]            | Correct spelling of all arguments       |
| [CSH_JUNKIE_HISTORY]     | Single `!` for previous command         |
| [CSH_JUNKIE_LOOPS]       | `list; end` for `do...done`             |
| [CSH_JUNKIE_QUOTES]      | No newlines in quotes                   |
| [CSH_NULLCMD]            | Redirections with no commands fail      |
| [CSH_NULL_GLOB]          | One glob must succeed, failures go      |
| [DVORAK]                 | Dvorak keyboard for correction          |
| [EMACS]                  | Same as `bindkey -e`                    |
| \*[EQUALS]               | Expand `=cmd` to `/path/to/cmd`         |
| [ERR_EXIT]               | Exit shell on non-zero status           |
| [ERR_RETURN]             | Return from function instead            |
| \*[EVAL_LINE_NO]         | `$LINENO` counts inside `eval` code     |
| \*[EXEC]                 | Execute commands                        |
| [EXTENDED_GLOB]          | See globbing section above              |
| [EXTENDED_HISTORY]       | Timestamps saved to history file        |
| \*[FLOW_CONTROL]         | Use `^S/^Q` style flow control          |
| \*[FUNCTION_ARGZER0]     | `$0` in function is its name            |
| \*[GLOB]                 | Use globbing as described above         |
| \*[GLOBAL_EXPORT]        | Exported variables not made local       |
| \*[GLOBAL_RCS]           | Execute `/etc/z*` files                 |
| [GLOB_ASSIGN]            | `var=*` expands, assigns array          |
| [GLOB_COMPLETE]          | Patterns are active in completion       |
| [GLOB_DOTS]              | Patterns may match leading dots         |
| [GLOB_SUBST]             | Substituted characters may glob         |
| \*[HASH_CMDS]            | Store command location for speed        |
| \*[HASH_DIRS]            | Store for all commands in dir           |
| \*[HASH_LIST_ALL]        | Store all on first completion           |
| [HIST_ALLOW_CLOBBER]     | On clobber error, up arrow to retry     |
| \*[HIST_BEEP]            | Beep when going beyond history          |
| [HIST_EXPIRE_DUPS_FIRST] | Duplicate history entries lost first    |
| [HIST_FIND_NO_DUPS]      | History search finds once only          |
| [HIST_IGNORE_ALL_DUPS]   | Remove all earlier duplicate lines      |
| [HIST_IGNORE_DUPS]       | Remove duplicate of previous line       |
| [HIST_IGNORE_SPACE]      | Don’t store lines starting with space   |
| [HIST_NO_FUNCTIONS]      | Don’t store shell functions             |
| [HIST_NO_STORE]          | Don’t store `history` and `fc`          |
| [HIST_REDUCE_BLANKS]     | Trim multiple insignificant blanks      |
| [HIST_SAVE_NO_DUPS]      | Remove duplicates when saving           |
| [HIST_VERIFY]            | Show `!` history line for editing       |
| \*[HUP]                  | Send SIGHUP to proceses on exit         |
| [IGNORE_BRACES]          | Don’t use {a,b} expansions              |
| [IGNORE_EOF]             | Ignore `^D` (`stty eof` char)           |
| [INC_APPEND_HISTORY]     | Save history line by line               |
| [INTERACTIVE]            | Shell is interactive                    |
| [INTERACTIVE_COMMENTS]   | `#` on interactive line for comment     |
| [KSH_ARRAYS]             | Indexing etc. for arrays like ksh       |
| [KSH_AUTOLOAD]           | Function file includes function name    |
| [KSH_GLOB]               | See globbing above                      |
| [KSH_OPTION_PRINT]       | Show all options plus on or off         |
| [KSH_TYPESET]            | No word splitting in`typeset` etc.      |
| \*[LIST_AMBIGUOUS]       | List completions when ambiguous         |
| \*[LIST_BEEP]            | Beep on ambiguous completion            |
| [LIST_PACKED]            | More compact completion lists           |
| [LIST_ROWS_FIRST]        | List completions across                 |
| \*[LIST_TYPES]           | File types listed in completion         |
| [LOCAL_OPTIONS]          | Options reset on function return        |
| [LOCAL_TRAPS]            | Traps reset on function return          |
| [LOGIN]                  | Shell is login shell                    |
| [LONG_LIST_JOBS]         | More verbose listing of jobs            |
| [MAGIC_EQUAL_SUBST]      | Special expansion after all `=`         |
| [MAIL_WARNING]           | Warn if mail file timestamp changed     |
| [MARK_DIRS]              | Append `/` to globbed directories       |
| [MENU_COMPLETE]          | Cycle through ambiguous matches         |
| [MONITOR]                | Shell has job control enabled           |
| \*[MULTIOS]              | Multiple redirections are special       |
| \*[NOMATCH]              | Error if glob fails to match            |
| \*[NOTIFY]               | Asynchronous job control messages       |
| [NULL_GLOB]              | Failed globs are removed from line      |
| [NUMERIC_GLOB_SORT]      | Numbers in globs sorted numerically     |
| [OCTAL_ZEROES]           | Leading zeros in integers force octal   |
| [OVERSTRIKE]             | Start line editor in overstrike mode    |
| [PATH_DIRS]              | `dir/cmd` can be found in `$PATH`       |
| [POSIX_BUILTINS]         | Illogical command behaviour             |
| [PRINT_EIGHT_BIT]        | Print all 8-bit characters directly     |
| [PRINT_EXIT_VALUE]       | Return status printed unless zero       |
| [PRIVILEGED]             | Special behaviour on setuid/setgid      |
| [PROMPT_BANG]            | Special treatment of `!` in prompt      |
| \*[PROMPT_CR]            | Prompt always at start of line          |
| \*[PROMPT_PERCENT]       | `%` escapes expanded in prompts         |
| [PROMPT_SUBST]           | `$` expansion etc. in prompts           |
| [PUSHD_IGNORE_DUPS]      | Don’t push dir multiply on stack        |
| [PUSHD_MINUS]            | Reverse sense of `–` and `+` in `pushd` |
| [PUSHD_SILENT]           | No non-err messages from `pushd`        |
| [PUSHD_TO_HOME]          | `pushd` with no argument goes to `~`    |
| [RC_EXPAND_PARAM]        | `X$array` gives `Xelt1` `Xelt2` etc.    |
| [RC_QUOTES]              | `''` inside single quotes gives `'`     |
| \*[RCS]                  | Run startup files                       |
| [REC_EXACT]              | Exact completion matches are good       |
| [RESTRICTED]             | Shell has restricted capabilities       |
| [RM_STAR_SILENT]         | Don’t warn on `rm *`                    |
| [RM_STAR_WAIT]           | Wait before asking if `rm *` is OK      |
| [SHARE_HISTORY]          | Save and restore history per line       |
| [SH_FILE_EXPANSION]      | `~` etc. expansion done early           |
| [SH_GLOB]                | Disables non-extended zsh globs         |
| [SHIN_STDIN]             | Shell input comes from stdin            |
| [SH_NULL_CMD]            | Commandless redirections like `sh`      |
| [SH_OPTION_LETTERS]      | Single letter options are like `sh`     |
| \*[SHORT_LOOPS]          | `for words; list` works                 |
| [SH_WORD_SPLIT]          | Split non-array variables yuckily       |
| [SINGLE_COMMAND]         | Execute one command then exit           |
| [SINGLE_LINE_ZLE]        | Line editing on single line (bad tty)   |
| [SUN_KEYBOARD_HACK]      | Unmatched `\`` at end of line ignored   |
| [TRANSIENT_RPROMPT]      | Right prompt goes away after edit       |
| [TRAPS_ASYNC]            | Traps may run when `wait`ing            |
| [TYPESET_SILENT]         | Silent on `typeset foo`                 |
| \*[UNSET]                | Unset variables OK, treat as empty      |
| [VERBOSE]                | Output commands to be executed          |
| [VI]                     | Same as `bindkey -v`                    |
| [XTRACE]                 | Show trace of execution with `$PS4`     |
| [ZLE]                    | Line editor used to input lines         |


[ALIASES]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-ALIASES
[ALL_EXPORT]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-ALL_EXPORT
[ALWAYS_LAST_PROMPT]:      https://zsh.sourceforge.io/Doc/Release/Options.html#index-ALWAYS_LAST_PROMPT
[ALWAYS_TO_END]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-ALWAYS_TO_END
[APPEND_HISTORY]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-APPEND_HISTORY
[AUTO_CD]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_CD
[AUTO_CONTINUE]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_CONTINUE
[AUTO_LIST]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_LIST
[AUTO_MENU]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_MENU
[AUTO_NAME_DIRS]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_NAME_DIRS
[AUTO_PARAM_KEYS]:         https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_PARAM_KEYS
[AUTO_PARAM_SLASH]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_PARAM_SLASH
[AUTO_PUSHD]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_PUSHD
[AUTO_REMOVE_SLASH]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_REMOVE_SLASH
[AUTO_RESUME]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-AUTO_RESUME
[BAD_PATTERN]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-BAD_PATTERN
[BANG_HIST]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-BANG_HIST
[BARE_GLOB_QUAL]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-BARE_GLOB_QUAL
[BASH_AUTO_LIST]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-BASH_AUTO_LIST
[BEEP]:                    https://zsh.sourceforge.io/Doc/Release/Options.html#index-BEEP
[BG_NICE]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-BG_NICE
[BRACE_CCL]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-BRACE_CCL
[BSD_ECHO]:                https://zsh.sourceforge.io/Doc/Release/Options.html#index-BSD_ECHO
[CASE_GLOB]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-CASE_GLOB
[C_BASES]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-C_BASES
[CDABLE_VARS]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-CDABLE_VARS
[CHASE_DOTS]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-CHASE_DOTS
[CHASE_LINKS]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-CHASE_LINKS
[CHECK_JOBS]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-CHECK_JOBS
[CLOBBER]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-CLOBBER
[COMPLETE_ALIASES]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-COMPLETE_ALIASES
[COMPLETE_IN_WORD]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-COMPLETE_IN_WORD
[CORRECT]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-CORRECT
[CORRECT_ALL]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-CORRECT_ALL
[CSH_JUNKIE_HISTORY]:      https://zsh.sourceforge.io/Doc/Release/Options.html#index-CSH_JUNKIE_HISTORY
[CSH_JUNKIE_LOOPS]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-CSH_JUNKIE_LOOPS
[CSH_JUNKIE_QUOTES]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-CSH_JUNKIE_QUOTES
[CSH_NULLCMD]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-CSH_NULLCMD
[CSH_NULL_GLOB]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-CSH_NULL_GLOB
[DVORAK]:                  https://zsh.sourceforge.io/Doc/Release/Options.html#index-DVORAK
[EMACS]:                   https://zsh.sourceforge.io/Doc/Release/Options.html#index-EMACS
[EQUALS]:                  https://zsh.sourceforge.io/Doc/Release/Options.html#index-EQUALS
[ERR_EXIT]:                https://zsh.sourceforge.io/Doc/Release/Options.html#index-ERR_EXIT
[ERR_RETURN]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-ERR_RETURN
[EVAL_LINE_NO]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-EVAL_LINE_NO
[EXEC]:                    https://zsh.sourceforge.io/Doc/Release/Options.html#index-EXEC
[EXTENDED_GLOB]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-EXTENDED_GLOB
[EXTENDED_HISTORY]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-EXTENDED_HISTORY
[FLOW_CONTROL]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-FLOW_CONTROL
[FUNCTION_ARGZER0]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-FUNCTION_ARGZER0
[GLOB]:                    https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOB
[GLOBAL_EXPORT]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOBAL_EXPORT
[GLOBAL_RCS]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOBAL_RCS
[GLOB_ASSIGN]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOB_ASSIGN
[GLOB_COMPLETE]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOB_COMPLETE
[GLOB_DOTS]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOB_DOTS
[GLOB_SUBST]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-GLOB_SUBST
[HASH_CMDS]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-HASH_CMDS
[HASH_DIRS]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-HASH_DIRS
[HASH_LIST_ALL]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-HASH_LIST_ALL
[HIST_ALLOW_CLOBBER]:      https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_ALLOW_CLOBBER
[HIST_BEEP]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_BEEP
[HIST_EXPIRE_DUPS_FIRST]:  https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_EXPIRE_DUPS_FIRST
[HIST_FIND_NO_DUPS]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_FIND_NO_DUPS
[HIST_IGNORE_ALL_DUPS]:    https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_IGNORE_ALL_DUPS
[HIST_IGNORE_DUPS]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_IGNORE_DUPS
[HIST_IGNORE_SPACE]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_IGNORE_SPACE
[HIST_NO_FUNCTIONS]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_NO_FUNCTIONS
[HIST_NO_STORE]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_NO_STORE
[HIST_REDUCE_BLANKS]:      https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_REDUCE_BLANKS
[HIST_SAVE_NO_DUPS]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_SAVE_NO_DUPS
[HIST_VERIFY]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-HIST_VERIFY
[HUP]:                     https://zsh.sourceforge.io/Doc/Release/Options.html#index-HUP
[IGNORE_BRACES]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-IGNORE_BRACES
[IGNORE_EOF]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-IGNORE_EOF
[INC_APPEND_HISTORY]:      https://zsh.sourceforge.io/Doc/Release/Options.html#index-INC_APPEND_HISTORY
[INTERACTIVE]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-INTERACTIVE
[INTERACTIVE_COMMENTS]:    https://zsh.sourceforge.io/Doc/Release/Options.html#index-INTERACTIVE_COMMENTS
[KSH_ARRAYS]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-KSH_ARRAYS
[KSH_AUTOLOAD]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-KSH_AUTOLOAD
[KSH_GLOB]:                https://zsh.sourceforge.io/Doc/Release/Options.html#index-KSH_GLOB
[KSH_OPTION_PRINT]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-KSH_OPTION_PRINT
[KSH_TYPESET]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-KSH_TYPESET
[LIST_AMBIGUOUS]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-LIST_AMBIGUOUS
[LIST_BEEP]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-LIST_BEEP
[LIST_PACKED]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-LIST_PACKED
[LIST_ROWS_FIRST]:         https://zsh.sourceforge.io/Doc/Release/Options.html#index-LIST_ROWS_FIRST
[LIST_TYPES]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-LIST_TYPES
[LOCAL_OPTIONS]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-LOCAL_OPTIONS
[LOCAL_TRAPS]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-LOCAL_TRAPS
[LOGIN]:                   https://zsh.sourceforge.io/Doc/Release/Options.html#index-LOGIN
[LONG_LIST_JOBS]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-LONG_LIST_JOBS
[MAGIC_EQUAL_SUBST]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-MAGIC_EQUAL_SUBST
[MAIL_WARNING]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-MAIL_WARNING
[MARK_DIRS]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-MARK_DIRS
[MENU_COMPLETE]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-MENU_COMPLETE
[MONITOR]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-MONITOR
[MULTIOS]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-MULTIOS
[NOMATCH]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-NOMATCH
[NOTIFY]:                  https://zsh.sourceforge.io/Doc/Release/Options.html#index-NOTIFY
[NULL_GLOB]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-NULL_GLOB
[NUMERIC_GLOB_SORT]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-NUMERIC_GLOB_SORT
[OCTAL_ZEROES]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-OCTAL_ZEROES
[OVERSTRIKE]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-OVERSTRIKE
[PATH_DIRS]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-PATH_DIRS
[POSIX_BUILTINS]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-POSIX_BUILTINS
[PRINT_EIGHT_BIT]:         https://zsh.sourceforge.io/Doc/Release/Options.html#index-PRINT_EIGHT_BIT
[PRINT_EXIT_VALUE]:        https://zsh.sourceforge.io/Doc/Release/Options.html#index-PRINT_EXIT_VALUE
[PRIVILEGED]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-PRIVILEGED
[PROMPT_BANG]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-PROMPT_BANG
[PROMPT_CR]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-PROMPT_CR
[PROMPT_PERCENT]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-PROMPT_PERCENT
[PROMPT_SUBST]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-PROMPT_SUBST
[PUSHD_IGNORE_DUPS]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-PUSHD_IGNORE_DUPS
[PUSHD_MINUS]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-PUSHD_MINUS
[PUSHD_SILENT]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-PUSHD_SILENT
[PUSHD_TO_HOME]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-PUSHD_TO_HOME
[RC_EXPAND_PARAM]:         https://zsh.sourceforge.io/Doc/Release/Options.html#index-RC_EXPAND_PARAM
[RC_QUOTES]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-RC_QUOTES
[RCS]:                     https://zsh.sourceforge.io/Doc/Release/Options.html#index-RCS
[REC_EXACT]:               https://zsh.sourceforge.io/Doc/Release/Options.html#index-REC_EXACT
[RESTRICTED]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-RESTRICTED
[RM_STAR_SILENT]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-RM_STAR_SILENT
[RM_STAR_WAIT]:            https://zsh.sourceforge.io/Doc/Release/Options.html#index-RM_STAR_WAIT
[SHARE_HISTORY]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-SHARE_HISTORY
[SH_FILE_EXPANSION]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-SH_FILE_EXPANSION
[SH_GLOB]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-SH_GLOB
[SHIN_STDIN]:              https://zsh.sourceforge.io/Doc/Release/Options.html#index-SHIN_STDIN
[SH_NULL_CMD]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-SH_NULL_CMD
[SH_OPTION_LETTERS]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-SH_OPTION_LETTERS
[SHORT_LOOPS]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-SHORT_LOOPS
[SH_WORD_SPLIT]:           https://zsh.sourceforge.io/Doc/Release/Options.html#index-SH_WORD_SPLIT
[SINGLE_COMMAND]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-SINGLE_COMMAND
[SINGLE_LINE_ZLE]:         https://zsh.sourceforge.io/Doc/Release/Options.html#index-SINGLE_LINE_ZLE
[SUN_KEYBOARD_HACK]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-SUN_KEYBOARD_HACK
[TRANSIENT_RPROMPT]:       https://zsh.sourceforge.io/Doc/Release/Options.html#index-TRANSIENT_RPROMPT
[TRAPS_ASYNC]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-TRAPS_ASYNC
[TYPESET_SILENT]:          https://zsh.sourceforge.io/Doc/Release/Options.html#index-TYPESET_SILENT
[UNSET]:                   https://zsh.sourceforge.io/Doc/Release/Options.html#index-UNSET
[VERBOSE]:                 https://zsh.sourceforge.io/Doc/Release/Options.html#index-VERBOSE
[VI]:                      https://zsh.sourceforge.io/Doc/Release/Options.html#index-VI
[XTRACE]:                  https://zsh.sourceforge.io/Doc/Release/Options.html#index-XTRACE
[ZLE]:                     https://zsh.sourceforge.io/Doc/Release/Options.html#index-ZLE
