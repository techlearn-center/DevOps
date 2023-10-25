## User Creation:
### Create users for 5 new employees: Alice, Bob, Charlie, Dave, and Eve.

```
sudo useradd Alice
```
```
sudo useradd Bob
```
```
sudo useradd Charlie
```
```
sudo useradd Dave
```
```
sudo useradd Eve
```
### Set up strong passwords for each user and ensure they change it at the first login.

To set strong passwords for each user:
```
sudo passwd Alice
```
```
sudo passwd Bob
```
```
sudo passwd Charlie
```
```
sudo passwd Dave
```
```
sudo passwd Eve
```

To ensure they change their passwords at the first login, you can use ``` chage ``` command:

![Screenshot](./change_password.PNG)
