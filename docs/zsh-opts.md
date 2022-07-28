# Zsh Options

Set options with `setopt`, unset with `unsetopt`. Options can take a `NO_` prefix as
well (eg: `setopt NO_BEEP` is the same as `unsetopt BEEP`). You can view set options via
the `set -o` command. You can see only enabled options with `set -o | grep 'on$'`.

Asterisk (\*) indicates the option is on by default for native zsh.

## Changing Directories

[16.2.1 Changing Directories][16.2.1]

| Option            | Short Description                           |
|-------------------|---------------------------------------------|
| AUTO_CD           | If a command is dir name, `cd` to it        |
| AUTO_PUSHD        | `cd` pushes to directory stack              |
| CDABLE_VARS       | `cd var` works if `$var` is directory       |
| CD_SILENT         | Don't print the dir after `cd`              |
| CHASE_DOTS        | Resolve symlinks when `..` in `cd`          |
| CHASE_LINKS       | Resolve symlinks in `cd`                    |
| POSIX_CD          | Change behavior of `cd`, `chdir`, & `pushd` |
| PUSHD_IGNORE_DUPS | Don’t push duplicate dirs onto stack        |
| PUSHD_MINUS       | Reverse meanings of `–` and `+` in `pushd`  |
| PUSHD_SILENT      | Don't print the dir stack after `pushd`     |
| PUSHD_TO_HOME     | `pushd` with no argument goes to `~`        |

## Completion

[16.2.2 Completion][16.2.2]

| Option               | Short Description                  |
|----------------------|------------------------------------|
| ALWAYS_LAST_PROMPT\* | Completion lists after prompt      |
| ALWAYS_TO_END        | On completion go to end of word    |
| AUTO_LIST\*          | List ambiguous completions         |
| AUTO_MENU\*          | Menu complete after two tabs       |
| AUTO_NAME_DIRS       | Variables always can be %~ abbrevs |
| AUTO_PARAM_KEYS\*    | Magic completion for parameters    |
| AUTO_PARAM_SLASH\*   | `$dirname` completes with `/`      |
| AUTO_REMOVE_SLASH\*  | Trailing `/` in completion removed |
| BASH_AUTO_LIST       | List completions on second tab     |
| COMPLETE_ALIASES     | Completion uses unexpanded aliases |
| COMPLETE_IN_WORD     | Completion works inside words      |
| GLOB_COMPLETE        | Patterns are active in completion  |
| HASH_LIST_ALL\*      | Store all on first completion      |
| LIST_AMBIGUOUS\*     | List completions when ambiguous    |
| LIST_BEEP\*          | Beep on ambiguous completion       |
| LIST_PACKED          | More compact completion lists      |
| LIST_ROWS_FIRST      | List completions across            |
| LIST_TYPES\*         | File types listed in completion    |
| MENU_COMPLETE        | Cycle through ambiguous matches    |
| REC_EXACT            | Exact completion matches are used  |

## Expansion and Globbing

[16.2.3 Expansion and Globbing][16.2.3]

| Option              | Short Description                              |
|---------------------|------------------------------------------------|
| BAD_PATTERN\*       | Errors on pattern syntax; else literal         |
| BARE_GLOB_QUAL\*    | Glob qualifiers with bare parens               |
| BRACE_CCL           | `X{ab}` expands to `Xa` `Xb`                   |
| CASE_GLOB\*         | Make globbing case-sensitive                   |
| CASE_MATCH          | Make regex case-sensitive                      |
| CASE_PATHS          | Make paths case-sensitive                      |
| CSH_NULL_GLOB       | One glob must succeed, failed globs ignored    |
| EQUALS\*            | Expand `=cmd` to `/path/to/cmd`                |
| EXTENDED_GLOB       | Expand globbing syntax                         |
| FORCE_FLOAT         | Treat numbers as floats when doing arithmetic  |
| GLOB\*              | Enable globbing                                |
| GLOB_ASSIGN         | `var=*` expands, assigns array                 |
| GLOB_DOTS           | Patterns may match leading dots                |
| GLOB_STAR_SHORT     | Allow `**`,`***` shorthand for `**/*`,`***/*`  |
| GLOB_SUBST          | Substituted characters may glob                |
| HIST_SUBST_PATTERN  | History modifiers match by pattern, not string |
| IGNORE_BRACES       | Don’t use `{a,b}` expansions                   |
| IGNORE_CLOSE_BRACES | Do not perform brace expansion                 |
| KSH_GLOB            | Globbing matches KornShell                     |
| MAGIC_EQUAL_SUBST   | Special expansion after all `=`                |
| MARK_DIRS           | Append `/` to globbed directories              |
| MULTIBYTE           | Respect multibyte characters in strings        |
| NOMATCH\*           | Error if glob fails to match                   |
| NULL_GLOB           | Failed globs are removed from line             |
| NUMERIC_GLOB_SORT   | Numbers in globs sorted numerically            |
| RC_EXPAND_PARAM     | `X$array` gives `Xelt1` `Xelt2` etc.           |
| REMATCH_PCRE        | Use Perl-compatible regex syntax for `=~`      |
| SH_GLOB             | Disables non-extended zsh globs                |
| UNSET\*             | Unset variables OK, treat as empty             |
| WARN_CREATE_GLOBAL  | Warn when a function makes a global var        |
| WARN_NESTED_VAR     | Warn when a nested function var violates scope |

## History

[16.2.4 History][16.2.4]

| Option                  | Short Description                                |
|-------------------------|--------------------------------------------------|
| APPEND_HISTORY\*        | History appends to existing file                 |
| BANG_HIST\*             | `!` style history allowed                        |
| EXTENDED_HISTORY        | Timestamps saved to history file                 |
| HIST_ALLOW_CLOBBER      | On clobber error, up arrow to retry              |
| HIST_BEEP\*             | Beep when going beyond history                   |
| HIST_EXPIRE_DUPS_FIRST  | Duplicate history entries lost first             |
| HIST_FCNTL_LOCK         | Use `fcntl` for histfile locking                 |
| HIST_FIND_NO_DUPS       | History search finds once only                   |
| HIST_IGNORE_ALL_DUPS    | Remove earlier dups and store recent             |
| HIST_IGNORE_DUPS        | Do not write history if dupe exists              |
| HIST_IGNORE_SPACE       | Don’t store lines starting with space            |
| HIST_LEX_WORDS          | Use lexer to detect quoted whitespace            |
| HIST_NO_FUNCTIONS       | Don’t store shell functions                      |
| HIST_NO_STORE           | Don’t store `history` and `fc`                   |
| HIST_REDUCE_BLANKS      | Trim multiple insignificant blanks               |
| HIST_SAVE_BY_COPY\*     | histfile is written as copy instead of in situ   |
| HIST_SAVE_NO_DUPS       | Remove duplicates when saving                    |
| HIST_VERIFY             | Show `!` history line for editing                |
| INC_APPEND_HISTORY      | Save history line by line                        |
| INC_APPEND_HISTORY_TIME | Save history after command completes with timing |
| SHARE_HISTORY           | Save and restore history per line                |

## Initialization

[16.2.5 Initialization][16.2.5]

| Option          | Short Description                   |
|-----------------|-------------------------------------|
| ALL_EXPORT      | Export all variables to environment |
| GLOBAL_EXPORT\* | Exported variables not made local   |
| GLOBAL_RCS\*    | Execute `/etc/z*` files             |
| RCS\*           | Run startup files                   |

## I/O

[16.2.6 Input/Output][16.2.6]

| Option               | Short Description                        |
|----------------------|------------------------------------------|
| ALIASES\*            | Expand aliases                           |
| CLOBBER\*            | Allow redirections to overwrite          |
| CORRECT              | Correct spelling of commands             |
| CORRECT_ALL          | Correct spelling of all arguments        |
| DVORAK               | Dvorak keyboard for correction           |
| FLOW_CONTROL\*       | Use `^S/^Q` style flow control           |
| HASH_CMDS\*          | Store command location for speed         |
| HASH_DIRS\*          | Store for all commands in dir            |
| IGNORE_EOF           | Ignore `^D` (`stty eof` char)            |
| INTERACTIVE_COMMENTS | `#` on interactive line for comment      |
| MAIL_WARNING         | Warn if mail file timestamp changed      |
| PATH_DIRS            | `dir/cmd` can be found in `$PATH`        |
| PRINT_EIGHT_BIT      | Print all 8-bit characters directly      |
| PRINT_EXIT_VALUE     | Return status printed unless zero        |
| RC_QUOTES            | `''` inside single quotes gives `'`      |
| RM_STAR_SILENT       | Don’t warn on `rm *`                     |
| RM_STAR_WAIT         | Wait before asking if `rm *` is OK       |
| SHORT_LOOPS\*        | `for words; list` works                  |
| SUN_KEYBOARD_HACK    | Unmatched `` ` `` at end of line ignored |

## Job Control

[16.2.7 Job Control][16.2.7]

| Option         | Short Description                  |
|----------------|------------------------------------|
| AUTO_CONTINUE  | Jobs are continued when `disown`ed |
| AUTO_RESUME    | `cmd` can resume job `%cmd`        |
| BG_NICE\*      | Background jobs at lower priority  |
| CHECK_JOBS\*   | Check jobs before exiting shell    |
| HUP\*          | Send SIGHUP to proceses on exit    |
| LONG_LIST_JOBS | More verbose listing of jobs       |
| MONITOR        | Shell has job control enabled      |
| NOTIFY\*       | Asynchronous job control messages  |

## Prompting

[16.2.8 Prompting][16.2.8]

| Option            | Short Description                  |
|-------------------|------------------------------------|
| PROMPT_BANG       | Special treatment of `!` in prompt |
| PROMPT_CR\*       | Prompt always at start of line     |
| PROMPT_PERCENT\*  | `%` escapes expanded in prompts    |
| PROMPT_SUBST      | `$` expansion etc. in prompts      |
| TRANSIENT_RPROMPT | Right prompt goes away after edit  |

## Scripts and Functions

[16.2.9 Scripts and Functions][16.2.9]

| Option             | Short Description                     |
|--------------------|---------------------------------------|
| C_BASES            | Output hexadecimal with `0x`          |
| ERR_EXIT           | Exit shell on non-zero status         |
| ERR_RETURN         | Return from function instead          |
| EVAL_LINE_NO\*     | `$LINENO` counts inside `eval` code   |
| EXEC\*             | Execute commands                      |
| FUNCTION_ARGZER0\* | `$0` in function is its name          |
| LOCAL_OPTIONS      | Options reset on function return      |
| LOCAL_TRAPS        | Traps reset on function return        |
| MULTIOS\*          | Multiple redirections are special     |
| OCTAL_ZEROES       | Leading zeros in integers force octal |
| TYPESET_SILENT     | Silent on `typeset foo`               |
| VERBOSE            | Output commands to be executed        |
| XTRACE             | Show trace of execution with `$PS4`   |

## Shell Emulation

[16.2.10 Shell Emulation][16.2.10]

| Option             | Short Description                    |
|--------------------|--------------------------------------|
| BSD_ECHO           | No echo escapes unless `-e` given    |
| CSH_JUNKIE_HISTORY | Single `!` for previous command      |
| CSH_JUNKIE_LOOPS   | `list; end` for `do...done`          |
| CSH_JUNKIE_QUOTES  | No newlines in quotes                |
| CSH_NULLCMD        | Redirections with no commands fail   |
| KSH_ARRAYS         | Indexing etc. for arrays like ksh    |
| KSH_AUTOLOAD       | Function file includes function name |
| KSH_OPTION_PRINT   | Show all options plus on or off      |
| KSH_TYPESET        | No word splitting in`typeset` etc.   |
| POSIX_BUILTINS     | Illogical command behaviour          |
| SH_FILE_EXPANSION  | `~` etc. expansion done early        |
| SH_NULL_CMD        | Commandless redirections like `sh`   |
| SH_OPTION_LETTERS  | Single letter options are like `sh`  |
| SH_WORD_SPLIT      | Split non-array variables yuckily    |
| TRAPS_ASYNC        | Traps may run when `wait`ing         |

## Shell State

[16.2.11 Shell State][16.2.11]

| Option         | Short Description                  |
|----------------|------------------------------------|
| INTERACTIVE    | Shell is interactive               |
| LOGIN          | Shell is login shell               |
| PRIVILEGED     | Special behaviour on setuid/setgid |
| RESTRICTED     | Shell has restricted capabilities  |
| SHIN_STDIN     | Shell input comes from stdin       |
| SINGLE_COMMAND | Execute one command then exit      |

## ZLE

[16.2.11 Zle][16.2.12]

| Option          | Short Description                         |
|-----------------|-------------------------------------------|
| BEEP\*          | Beep on errors                            |
| COMBINING_CHARS | Display diacritics properly               |
| EMACS           | Use Emacs editing. Prefer `bindkey -e`    |
| OVERSTRIKE      | Start line editor in overstrike mode      |
| SINGLE_LINE_ZLE | Line editing on single line (bad tty)     |
| VI              | Use vi modal editing. Prefer `bindkey -v` |
| ZLE             | Line editor used to input lines           |


[16.2.1]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Changing-Directories
[16.2.2]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Completion-4
[16.2.3]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Expansion-and-Globbing
[16.2.4]:   https://zsh.sourceforge.io/Doc/Release/Options.html#History
[16.2.5]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Initialisation
[16.2.6]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput
[16.2.7]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Job-Control
[16.2.8]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Prompting
[16.2.9]:   https://zsh.sourceforge.io/Doc/Release/Options.html#Scripts-and-Functions
[16.2.10]:  https://zsh.sourceforge.io/Doc/Release/Options.html#Shell-Emulation
[16.2.11]:  https://zsh.sourceforge.io/Doc/Release/Options.html#Shell-State
[16.2.12]:  https://zsh.sourceforge.io/Doc/Release/Options.html#Zle
