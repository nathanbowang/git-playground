import json
import os
import subprocess
import sys

def git_diff(before_commit, after_commit):
    command = f"git diff --name-only {before_commit} {after_commit}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    changed_files = result.stdout.strip().split('\n')
    print("Changed files:", changed_files)
    return changed_files

def list_users(changed_files):
    user_dirs = set()
    for file in changed_files:
        if file.startswith("src/users/"):
            parts = file.split(os.sep)
            if len(parts) > 2:
                user_dir = os.path.join(parts[0], parts[1], parts[2])
                user_dirs.add(user_dir)
    user_dirs = sorted(list(user_dirs))
    print("Users:", user_dirs)
    print("Is changed:", bool(user_dirs))
    # Output to GitHub action
    print(f"::set-output name=users::{' '.join(user_dirs)}")
    print(f"::set-output name=isChanged::{str(bool(user_dirs)).lower()}")

def main():
    if len(sys.argv) != 3:
        print("Usage: python list-changed-users.py <before_commit> <after_commit>")
        sys.exit(1)

    before_commit = sys.argv[1]
    after_commit = sys.argv[2]

    changed_files = git_diff(before_commit, after_commit)
    list_users(changed_files)

if __name__ == "__main__":
    main()
