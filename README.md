# mklimine

Tool to allow for easy scripting in Limine config file generation.

## Usage

Create a file at /etc/mklimine.conf and fill it in according to the file format.

Then run `mklimine` with any arguments wanted by your config.

## Config Format

### Sections:
"Sections" are shell commands surrounded by `[ brackets ]` on their own line that indicate the
following chunk of text to be processed. For example:
```sh
[ Parse ]
timeout: 3
default_entry: 2
```

The most useful command is Parse(), which parses the buffer according to the Limine config format,
evaluating values as shell expressions.

The text at the beginning of the file is not part of a section, and is evaluated before operating
on sections. This lets you set custom variables and functions:
```sh
getTimeout(){
    shuf -i 1-10 -n 1
}
ENTRY=2
[ Parse ]
timeout: "$(getTimeout)"
default_entry: $ENTRY
```

The processed output from each section is combined into a single file, limine.conf.

### Pre-defined variables:
- $Output -- output file, /dev/stdout by default.
- $Buffer -- file holding the contents of the current section.
- $ESP -- directory for system boot partition
- $OS_* -- variables from /etc/os-release, prepended with "OS_".

### Pre-defined functions:
- Parse() -- parse over $Buffer, evaluating values as shell expressions, appending to $Output.
- Print() -- same as echo, but does not interpret escape sequences.

### Extra:
See [extra-functions](./extra-functions).

## Example

See [mklimine.conf](./mklimine.conf).

## Usability

This probably isn't "user-friendly" since it requires that you know at least a little shell
scripting. But a simple limine.conf is already easy to make, so this project is aimed more at
advanced users anyway.

If you do know shell scripting, mklimine is a very powerful tool for generating arbitrarily complex
config files.

## Internals

The core logic of mklimine is only about 70 lines of shell and awk script, doing about 4 things:
- Evaluate/Source beginning of file as shell code
- Find text that follows `[ section ]` syntax
- Put following text into a buffer named by the $Buffer variable
- Run section command with $Buffer available in scope

The Parse() function is not involved, except where used in mklimine.conf.

For that reason i might split this project into the core section processor with modular sets of
parsers. Think a limine parser, a rEFInd parser, an fstab parser, a mangowc config parser, or any
format that would benefit from dynamic generation. The section syntax would also be modular, to
avoid conflicts with other file types.

But right now i just use it for Limine.
