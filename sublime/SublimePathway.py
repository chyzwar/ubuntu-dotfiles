import os

# http://robdodson.me/hacking-the-path-variable-in-sublime-text/

CARGO = '/home/raziel/.cargo/bin:'
RBENV = '/home/raziel/.rbenv/shims:'
NODENV = '/home/raziel/.nodenv/shims:'
CRENV = '/home/raziel/.crenv/shims:'

# Add Stuff To Path
os.environ['PATH'] += ':'
os.environ['PATH'] += CARGO
os.environ['PATH'] += RBENV
os.environ['PATH'] += NODENV
os.environ['PATH'] += CRENV


print('PATH = ' + os.environ['PATH'])
