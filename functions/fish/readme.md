# zfishcmds

Pure Zsh implementation of [fish commands][fish-commands].

[fish-commands]: https://fishshell.com/docs/current/commands.html

| command                   | description                                                           | available          |
|---------------------------|-----------------------------------------------------------------------|--------------------|
| `abbr`                    | manage fish abbreviations                                             | :electric_plug:    |
| `alias`                   | create a function                                                     | :wrench:           |
| `and`                     | conditionally execute a command                                       | :white_check_mark: |
| `argparse`                | parse options passed to a fish script or function                     | :construction:     |
| `begin`                   | start a new block of code                                             | :wrench:           |
| `bg`                      | send jobs to background                                               | :wrench:           |
| `bind`                    | handle fish key bindings                                              | :wrench:           |
| `block`                   | temporarily block delivery of events                                  | :wrench:           |
| `break`                   | stop the current inner loop                                           | :wrench:           |
| `breakpoint`              | Launch debug mode                                                     | :x:                |
| `builtin`                 | run a builtin command                                                 | :wrench:           |
| `case`                    | conditionally execute a block of commands                             | :wrench:           |
| `cd`                      | change directory                                                      | :wrench:           |
| `cdh`                     | change to a recently visited directory                                | :construction:     |
| `command`                 | run a program                                                         | :wrench:           |
| `commandline`             | set or get the current command line buffer                            | :x:                |
| `complete`                | edit command specific tab-completions                                 | :x:                |
| `contains`                | test if a word is present in a list                                   | :construction:     |
| `continue`                | skip the remainder of the current iteration of the current inner loop | :wrench:           |
| `count`                   | count the number of elements of a list                                | :construction:     |
| `dirh`                    | print directory history                                               | :construction:     |
| `dirs`                    | print directory stack                                                 | :wrench:           |
| `disown`                  | remove a process from the list of jobs                                | :wrench:           |
| `echo`                    | display a line of text                                                | :wrench:           |
| `else`                    | execute command if a condition is not met                             | :wrench:           |
| `emit`                    | Emit a generic event                                                  | :x:                |
| `end`                     | end a block of commands.                                              | :wrench:           |
| `eval`                    | evaluate the specified commands                                       | :wrench:           |
| `exec`                    | execute command in current process                                    | :wrench:           |
| `exit`                    | exit the shell                                                        | :wrench:           |
| `false`                   | return an unsuccessful result                                         | :wrench:           |
| `fg`                      | bring job to foreground                                               | :wrench:           |
| `fish`                    | the friendly interactive shell                                        | :fish:             |
| `fish_breakpoint_prompt`  | define the prompt when stopped at a breakpoint                        | :fish:             |
| `fish_config`             | start the web-based configuration interface                           | :fish:             |
| `fish_git_prompt`         | output git information for use in a prompt                            | :fish:             |
| `fish_hg_prompt`          | output Mercurial information for use in a prompt                      | :fish:             |
| `fish_indent`             | indenter and prettifier                                               | :fish:             |
| `fish_key_reader`         | explore what characters keyboard keys send                            | :fish:             |
| `fish_mode_prompt`        | define the appearance of the mode indicator                           | :fish:             |
| `fish_opt`                | create an option spec for the argparse command                        | :fish:             |
| `fish_prompt`             | define the appearance of the command line prompt                      | :fish:             |
| `fish_right_prompt`       | define the appearance of the right-side command line prompt           | :fish:             |
| `fish_svn_prompt`         | output Subversion information for use in a prompt                     | :fish:             |
| `fish_update_completions` | Update completions using manual pages                                 | :fish:             |
| `fish_vcs_prompt`         | output version control system information for use in a prompt         | :fish:             |
| `for`                     | perform a set of commands multiple times.                             | :wrench:           |
| `funced`                  | edit a function interactively                                         | :white_check_mark: |
| `funcsave`                | save the definition of a function to the user's autoload directory    | :white_check_mark: |
| `function`                | create a function                                                     | :wrench:           |
| `functions`               | print or erase functions                                              | :wrench:           |
| `help`                    | display fish documentation                                            | :construction:     |
| `history`                 | Show and manipulate command history                                   | :wrench:           |
| `if`                      | conditionally execute a command                                       | :wrench:           |
| `isatty`                  | test if a file descriptor is a terminal                               | :x:                |
| `jobs`                    | print currently running jobs                                          | :wrench:           |
| `math`                    | Perform mathematics calculations                                      | :construction:     |
| `nextd`                   | move forward through directory history                                | :construction:     |
| `not`                     | negate the exit status of a job                                       | :white_check_mark: |
| `open`                    | open file in its default application                                  | :wrench:           |
| `or`                      | conditionally execute a command                                       | :white_check_mark: |
| `popd`                    | move through directory stack                                          | :wrench:           |
| `prevd`                   | move backward through directory history                               | :construction:     |
| `printf`                  | display text according to a format string                             | :wrench:           |
| `prompt_pwd`              | Print pwd suitable for prompt                                         | :construction:     |
| `psub`                    | perform process substitution                                          | :x:                |
| `pushd`                   | push directory to directory stack                                     | :wrench:           |
| `pwd`                     | output the current working directory                                  | :wrench:           |
| `random`                  | generate random number                                                | :construction:     |
| `read`                    | read line of input into variables                                     | :wrench:           |
| `realpath`                | Convert a path to an absolute path without symlinks                   | :wrench:           |
| `return`                  | stop the current inner function                                       | :wrench:           |
| `set`                     | display and change shell variables.                                   | :wrench:           |
| `set_color`               | set the terminal color                                                | :construction:     |
| `source`                  | evaluate contents of file.                                            | :wrench:           |
| `status`                  | query fish runtime information                                        | :x:                |
| `string`                  | manipulate strings                                                    | :construction:     |
| `string-collect`          | join strings into one                                                 | :construction:     |
| `string-escape`           | escape special characters                                             | :construction:     |
| `string-join`             | join strings with delimiter                                           | :construction:     |
| `string-join0`            | join strings with zero bytes                                          | :construction:     |
| `string-length`           | print string lengths                                                  | :construction:     |
| `string-lower`            | convert strings to lowercase                                          | :construction:     |
| `string-match`            | match substrings                                                      | :construction:     |
| `string-repeat`           | multiply a string                                                     | :construction:     |
| `string-replace`          | replace substrings                                                    | :construction:     |
| `string-split`            | split strings by delimiter                                            | :construction:     |
| `string-split0`           | split on zero bytes                                                   | :construction:     |
| `string-sub`              | extract substrings                                                    | :construction:     |
| `string-trim`             | remove trailing whitespace                                            | :construction:     |
| `string-unescape`         | expand escape sequences                                               | :construction:     |
| `string-upper`            | convert strings to uppercase                                          | :construction:     |
| `suspend`                 | suspend the current shell                                             | :wrench:           |
| `switch`                  | conditionally execute a block of commands                             | :wrench:           |
| `test`                    | perform tests on files and text                                       | :wrench:           |
| `time`                    | measure how long a command or block takes                             | :wrench:           |
| `trap`                    | perform an action when the shell receives a signal                    | :wrench:           |
| `true`                    | return a successful result                                            | :wrench:           |
| `type`                    | indicate how a command would be interpreted                           | :wrench:           |
| `ulimit`                  | set or get resource usage limits                                      | :wrench:           |
| `umask`                   | set or get the file creation mode mask                                | :wrench:           |
| `vared`                   | interactively edit the value of an environment variable               | :wrench:           |
| `wait`                    | wait for jobs to complete                                             | :wrench:           |
| `while`                   | perform a command multiple times                                      | :wrench:           |
