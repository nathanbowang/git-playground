import sys
import subprocess

def get_git_diff_output(before_commit, after_commit):
    command = f"git diff --name-only {before_commit} {after_commit}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout.strip().split('\n')

def process_changed_files(changed_files):
    # 这里可以添加额外的处理逻辑
    # 例如，可以调用 scripts/to-changed-users.py 脚本
    for file in changed_files:
        print(file)

def main():
    if len(sys.argv) != 3:
        print("Usage: python list-changed-users.py <before_commit> <after_commit>")
        sys.exit(1)

    before_commit = sys.argv[1]
    after_commit = sys.argv[2]

    changed_files = get_git_diff_output(before_commit, after_commit)
    print("changed_files")
    print(changed_files)
    process_changed_files(changed_files)
    print("process_changed_files")
    print(process_changed_files)

if __name__ == "__main__":
    main()