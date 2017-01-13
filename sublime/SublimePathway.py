import os

# http://robdodson.me/hacking-the-path-variable-in-sublime-text/

CARGO = '/home/raziel/.cargo/bin:'
RBENV = '/home/raziel/.rbenv/shims:'
NODENV = '/home/raziel/.nodenv/shims:'

# Add Stuff To Path
os.environ['PATH'] += ':'
os.environ['PATH'] += CARGO
os.environ['PATH'] += RBENV
os.environ['PATH'] += NODENV


print('PATH = ' + os.environ['PATH'])
