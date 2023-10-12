import argparse
import os

from pymongo import MongoClient


def change_password(host, admin_user, admin_password, user_name, user_pass):
    client = MongoClient(f'mongodb://{admin_user}:{admin_password}@{host}')
    db = client['auth_db']
    print(f'Changing password for user {user_name}.')
    db.command('updateUser', user_name, pwd=user_pass)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Change passwords for users in X-Road-Metrics Database.')
    parser.add_argument('--host', required=True, help='URL for the X-Road-Metrics Database.')
    parser.add_argument('--admin_user', required=True, help='Admin username for the X-Road-Metrics Database.')
    parser.add_argument('--admin_password', required=True, help='Admin password for the X-Road-Metrics Database.')
    parser.add_argument('--xroad_instance', required=True, help='X-Road instance identifier.')
    args = parser.parse_args()

    users = ['analyzer',
             'analyzer_interface',
             'anonymizer',
             'collector',
             'corrector',
             'reports']
    for user in users:
        username = f'{user}_{args.xroad_instance.upper()}'
        password = os.getenv(f'{user.upper()}_PASSWORD')
        change_password(args.host, args.admin_user, args.admin_password, username, password)
