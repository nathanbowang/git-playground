import unittest
from list_changed_users import list_users

class TestListUsers(unittest.TestCase):

    def test_list_users_with_changes(self):
        changed_files = [
            'scripts/list-changed-users.py',
            'src/users/mike/name.txt',
            'src/users/nathan/name.txt',
            'src/users/nathan/eg/eee',
            'src/users/README.md',
        ]
        expected_users = ['src/users/mike', 'src/users/nathan']
        actual_users = list_users(changed_files, "src/users/")
        self.assertEqual(actual_users, expected_users)

    def test_list_users_with_no_changes(self):
        changed_files = [
            'scripts/list-changed-users.py',
            'README.md',
        ]
        expected_users = []
        actual_users = list_users(changed_files, "src/users/")
        self.assertEqual(actual_users, expected_users)

    def test_list_users_with_different_users_dir(self):
        changed_files = [
            'src/infosec/users/mike/name.txt',
            'src/prod/users/mike/name.txt',
            'scripts/list-changed-users.py',
            'README.md',
        ]
        expected_users = ['src/infosec/users/mike']
        actual_users = list_users(changed_files, "src/infosec/users/")
        self.assertEqual(actual_users, expected_users)

if __name__ == '__main__':
    unittest.main()
