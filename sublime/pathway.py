import os

# http://robdodson.me/hacking-the-path-variable-in-sublime-text/

CARGO = '/home/raziel/.cargo/bin:'
RBENV = '/home/raziel/.rbenv/shims:'

# Add Stuff To Path
os.environ['PATH'] += ':'
os.environ['PATH'] += CARGO
os.environ['PATH'] += RBENV

print('PATH = ' + os.environ['PATH'])
