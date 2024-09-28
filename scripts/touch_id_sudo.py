#!/usr/bin/env python3
import os
import sys


def opener(path, flags):
    return os.open(path, flags, 0o444)


def main():
    path = "/etc/pam.d/sudo_local"
    contents = "auth       sufficient     pam_tid.so"

    if os.geteuid() != 0:
        os.execvp("sudo", ["sudo", "python3"] + sys.argv)

    os.umask(0)
    with open(path, "w", opener=opener) as f:
        f.write(contents)


if __name__ == "__main__":
    main()
