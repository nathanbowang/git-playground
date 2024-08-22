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

def list_users(changed_files, users_dir):
    user_dirs = set()
    for file in changed_files:
        if file.startswith(users_dir):
            parts = file.split(os.sep)
            if len(parts) > 2:
                user_dir = os.path.join(parts[0], parts[1], parts[2])
                user_dirs.add(user_dir)
    users = sorted(list(user_dirs))
    print("Users:", users)
    print("Is changed:", bool(users))
    return users

def main():
    if len(sys.argv) != 4:
        print("Usage: python list-changed-users.py <before_commit> <after_commit> <users_dir>")
        sys.exit(1)

    before_commit = sys.argv[1]
    after_commit = sys.argv[2]
    users_dir = sys.argv[3]

    changed_files = git_diff(before_commit, after_commit)
    users = list_users(changed_files, users_dir)

    # Output to GitHub action
    env_file = os.environ.get('GITHUB_OUTPUT')
    if env_file:
        with open(env_file, 'a') as f:
            f.write(f"users={json.dumps(users)}\n")
            f.write(f"isChanged={str(bool(users)).lower()}\n")

if __name__ == "__main__":
    main()
