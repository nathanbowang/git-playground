import sys
import subprocess

def git_diff(before_commit, after_commit):
    command = f"git diff --name-only {before_commit} {after_commit}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout.strip().split('\n')

def list_users(changed_files):
    for file in changed_files:
        print(file)

def main():
    if len(sys.argv) != 3:
        print("Usage: python list-changed-users.py <before_commit> <after_commit>")
        sys.exit(1)

    before_commit = sys.argv[1]
    after_commit = sys.argv[2]

    changed_files = git_diff(before_commit, after_commit)
    print("changed_files": changed_files)
    list_users(changed_files)

if __name__ == "__main__":
    main()