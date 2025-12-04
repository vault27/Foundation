# VIM

## ~/.vimrc

- syntax on
    - Enables syntax highlighting.
    - Loads color rules for the detected filetype (e.g., markdown, python, c, etc.)
    - Without this, Vim shows plain text.
    - Works only if Vim knows the filetype.
    ✔ Example: Markdown headings (#) or code fences get colored.

- filetype on
    - Enables filetype detection.
    - Vim inspects the filename, extension, and sometimes file contents to guess the file type.
    - Needed for syntax highlighting and plugins to work correctly.
    ✔ Example: Opening README.md → Vim sets filetype=markdown.

- filetype plugin on
    - Loads filetype-specific plugins.
    - Plugins live in: $VIMRUNTIME/ftplugin/<filetype>.vim
    - These plugins set filetype-specific settings such as: indentation rules, mappings, format options,comment strings
    ✔ Example: Markdown plugin defines how lists behave when pressing Enter.

- filetype indent on
    - Enables filetype-specific indentation rules.
    - These files live at: $VIMRUNTIME/indent/<filetype>.vim
    - They define how Vim should auto-indent based on the language.
    - Example: In Python: indent increases after :
    - In Markdown: indent list items automatically:
