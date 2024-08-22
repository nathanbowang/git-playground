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
    """
    Identify and return affected user directories from a list of changed files.

    :param changed_files: A list of file paths that have been changed
    :param users_dir: The base path of the users directory
    :return: A sorted list of affected user directories
    """
    user_dirs = set()  # Use a set to store unique user directories

    # Remove trailing slash and split the users_dir path
    users_dir_parts = users_dir.rstrip('/').split(os.sep)
    users_dir_depth = len(users_dir_parts)  # Calculate the depth of users_dir

    for file in changed_files:
        if file.startswith(users_dir):  # Only process files under users_dir
            parts = file.split(os.sep)
            # Ensure the path contains at least one user directory level
            if len(parts) > users_dir_depth + 1:
                # Construct the user directory path (one level deeper than users_dir)
                user_dir = os.sep.join(parts[:users_dir_depth + 1])
                
                # Determine if it's a directory by either:
                # 1. The path is deeper than the user directory (implying it contains files)
                # 2. The path ends with a slash (explicitly marked as a directory)
                if len(parts) > users_dir_depth + 1 or file.endswith('/'):
                    user_dirs.add(user_dir)

    # Convert the set to a sorted list
    users = sorted(list(user_dirs))
    
    # Print results (for debugging or informational purposes)
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
