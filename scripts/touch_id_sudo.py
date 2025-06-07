#!/usr/bin/env python3
import os
import sys

PAM_FILE = "/etc/pam.d/sudo_local"
PAM_LINE = "auth       sufficient     pam_tid.so\n"


def require_root():
    """Re-run the script with sudo if not running as root."""
    if os.geteuid() != 0:
        print("Re-running with sudo...")
        os.execvp("sudo", ["sudo", sys.executable] + sys.argv)


def write_pam_file(path, contents):
    """Write the pam_tid.so line to the sudo_local PAM file."""
    os.umask(0)

    def opener(p, flags):
        return os.open(p, flags, 0o444)

    with open(path, "w", opener=opener) as f:
        f.write(contents)


def main():
    require_root()
    write_pam_file(PAM_FILE, PAM_LINE)
    print(f"Touch ID enabled for sudo via {PAM_FILE}")


if __name__ == "__main__":
    main()
