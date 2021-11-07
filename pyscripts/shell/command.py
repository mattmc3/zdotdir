import subprocess
import shlex

def run(command):
    process = subprocess.Popen(shlex.split(command), shell=False, stdout=subprocess.PIPE)
    while True:
        output = process.stdout.readline()
        if not output and process.poll() is not None:
            break
        if output:
            print(output.decode(), end="")
    rc = process.poll()
    return rc
