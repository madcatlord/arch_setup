import subprocess as sb
import json
from sys import argv, exit
from typing import Any

if len(argv) <= 2:
    exit()

### NOTE: This program expects 2 cmdline arguments, which are the name of the browser to be used and the workspace ID to open it on
browser = argv[1] # Both the classname and cmd to launch the browser
wID = int(argv[2]) # Workspace ID to for the browser

def main():
    # GoTo workspace
    sb.run(f"hyprctl dispatch workspace {wID}".split(" "))

    # Get info on currently running programs
    clients = sb.run("hyprctl clients -j".split(" "), capture_output=True)
    parsed_clients: list[Any] = json.loads(clients.stdout)

    browser_present = False
    for client in parsed_clients:
        if client["workspace"]["id"] == wID and client["class"] == browser:
            browser_present = True

    # Start the browser on the specified workspace, if it hasnt already
    if not browser_present:
        sb.Popen(f"hyprctl dispatch exec [workspace {wID} silent] {browser}".split(" "))



if __name__ == "__main__":
    main()
