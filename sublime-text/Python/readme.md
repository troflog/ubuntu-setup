## Troubleshooting
This section lists some common issues faced by users, along with workarounds.

#### Anaconda does not appear in the Available Packages list on Package Control.

**Work-around**: You have to update your Package Control version to the version 2.0 or better.

#### Errors in the console about "the file can't be open" in worker.py file.
Your Sublime Text can't find the interpreter that you set in your configuration, by default, anaconda sets this as `python` so it will get your configured Python interpreter in your PATH (if any).

**Work-around**: Add a Python interpreter (named `python`) to your PATH or set a right full path to your python interpreter as parameter of `python_interpreter` settings option, for example `/usr/local/bin/python3.4`.

#### Auto-complete for import behaves badly.
Sublime Text 3's default Python package cancels the auto-completion when some words are detected (for example `def` or `class`). This list of words includes `import`.

**Work-around**: Create a new Python directory in your Packages directory and copy the contents of the file [Completion Rules.tmPreferences][Completion-Rules] there with the same name.
Delete your Sublime Text Cache file `Cache/Python/Completion Rules.tmPreferences.cache`.

**NOTE**: The cache path can be optained from the Sublime TExt 3 console using the code `sublime.cache_path()`

#### Auto-complete drop-down shows up incorrectly.
SublimeCodeIntel interferes with anaconda's auto-completion.

**Work-around**: Consider disabling SublimeCodeIntel for Python views or disabling/removing it completely when using anaconda.
