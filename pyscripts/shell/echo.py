import sys

def echo(msg, newline=True):
    end = "\n" if newline else ""
    print(msg, end=end)

def echoerr(msg, newline=True):
    end = "\n" if newline else ""
    print(msg, end=end, file=sys.stderr)
