#!/usr/bin/env python3
"""Merge versioned Claude Code settings into the existing settings.json.

Invoked from home/.claude/settings.json.tmpl via the mise template
engine's exec(): this script reads the *current* target file and writes
the merged result to stdout, which mise renders into the target. That
lets this file version the settings actually chosen while leaving
machine-local, Claude-generated state (notably the `autoMode.environment`
block) untouched and unpublished.

Under chezmoi the current contents arrived on stdin. mise templates have
no stdin, so the target path is passed as argv[1] and read here instead.
The merge semantics are unchanged.

Keys listed in MANAGED are authoritative here and overwrite whatever is
on disk. Every other key is passed through unchanged.

`hooks` is deliberately NOT managed. herdr owns its SessionStart hook and
rewrites it on `herdr integration install`; claiming the key here meant
the two overwrote each other in turn, and left a duplicate entry running
the same script twice per session.
"""

import json
import os
import sys

MANAGED = {
    # Keep Claude out of commit messages and PR bodies. Verified against
    # the 2.1.x binary, which reads `attribution` and `sessionUrl`.
    "attribution": {"commit": "", "pr": "", "sessionUrl": False},
    "statusLine": {
        "type": "command",
        "command": "bash ~/.claude/statusline-command.sh",
    },
    "enabledPlugins": {
        "claude-code-setup@claude-plugins-official": True,
        "superpowers@claude-plugins-official": True,
        "skill-creator@claude-plugins-official": True,
        "frontend-design@claude-plugins-official": True,
        "linear@claude-plugins-official": True,
        "code-review@claude-plugins-official": True,
        "posthog@claude-plugins-official": True,
    },
    "tui": "fullscreen",
    "skipWorkflowUsageWarning": True,
    "remoteControlAtStartup": True,
    "agentPushNotifEnabled": True,
    "skipAutoPermissionPrompt": True,
}


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: merge-claude-settings.py <target>", file=sys.stderr)
        return 2

    target = os.path.expanduser(sys.argv[1])

    # A missing file means a fresh machine; start from nothing.
    raw = ""
    if os.path.exists(target):
        with open(target, encoding="utf-8") as fh:
            raw = fh.read().strip()

    if raw:
        try:
            current = json.loads(raw)
        except json.JSONDecodeError as exc:
            # Never destroy a file we cannot parse -- pass it through and
            # complain on stderr so mise surfaces it.
            print(
                f"merge-claude-settings.py: target is not valid JSON: {exc}",
                file=sys.stderr,
            )
            sys.stdout.write(raw)
            return 0
        if not isinstance(current, dict):
            print(
                "merge-claude-settings.py: target is not a JSON object",
                file=sys.stderr,
            )
            sys.stdout.write(raw)
            return 0
    else:
        current = {}

    current.update(MANAGED)

    # ensure_ascii=False keeps em dashes and other non-ASCII intact rather
    # than rewriting them as \uXXXX, which would show up as spurious diffs.
    json.dump(current, sys.stdout, indent=2, ensure_ascii=False)
    sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
