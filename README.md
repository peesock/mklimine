# mklimine

Tool to allow for easy scripting in Limine config file generation.

## Usage

Create a file at /etc/mklimine.conf and fill it in according to the file format.

Then run `mklimine` with any arguments wanted by your config.

## File Format

### Sections:
"Sections" are function names surrounded by \[ brackets \] that contain text until the next section.
For each section, the $Buffer file is set to the contents of that section, and the function
represented by the section name is executed.

The most useful function is Parse(), which parses $Buffer according to the Limine config format,
but evaluates values as shell expressions, allowing for dynamic config creation.

The text at the beginning of the file is not part of a section, and is evaluated before operating
on sections. This lets you set custom variables and functions.

### Pre-defined variables:
- $Output -- file that Parse() appends output to, /dev/stdout by default.
- $Buffer -- file holding the contents of the current section.

### Pre-defined functions:
- Parse() -- parse over $Buffer, evaluating values as shell expressions, appending to $Output.
- Print() -- same as echo, but does not interpret escape sequences.
- Cleanup() -- is run on script exit. removes temp files.
- Exiter() -- is run after Cleanup(). empty by default.

### Example config:
See [mklimine.conf](./mklimine.conf). It offers initramfs generation in addition to limine config
creation.

## Project Status and Usability

This probably isn't "user-friendly." It currently has no built-in functions for typical mkinitcpio
and dracut usage, likely requiring the user to know some shell scripting to adapt the example config
to their own system.

However if you do know shell scripting, mklimine becomes a very simple and powerful tool for
generating arbitrarily complex limine config files.

The core logic of mklimine is only about 70 lines of shell and awk script, only really doing 4
things:
- Evaluate/Source beginning of file as shell code
- Find text that follows `[ Section ]` syntax
- Put following text into a buffer named by the $Buffer variable
- Execute a function with $Buffer available in scope

Parsing limine-style config files does not come into question. That is handled by a pre-defined
function Parse() separate from the core program.

For that reason i might split this project into the core section processor with modular sets of
parsers. Think a limine parser, an fstab parser, a mangowc config parser, etc. Any format that would
benefit from dynamic generation. The section syntax would also be modular, to avoid conflicts with
other file types.

But i'm only doing that if i actually want to use this for something other than Limine.
