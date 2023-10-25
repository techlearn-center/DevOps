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

Forcing a user to change their password at their first login is a security best practice, especially when the initial password is set by an administrator.
To ensure they change their passwords at the first login, you can use ``` chage ``` command with the ```-d 0``` option to set the user's "last password change" to the Unix epoch time (January 1, 1970). 
This effectively means the password is "expired".

```
sudo chage -d 0 Alice
```
```
sudo chage -d 0 Bob
```
```
sudo chage -d 0 Charlie
```
```
sudo chage -d 0 Dave
```
```
sudo chage -d 0 Eve
```

From the image below, we can see Bob is asked to change password at first login

<img src="./change_password.PNG" width="390" height="300">

## Group Management:
### Create three new groups: Developers, Designers, and HR.

To create the three new groups:
```
sudo groupadd Developers
```
```
sudo groupadd Designers
```
```
sudo groupadd HR
```


### Assign users to the groups based on the following:
#### Alice and Charlie are Developers.
#### Bob is a Designer.
#### Dave and Eve are in HR.

Assign users to the groups:
```
sudo usermod -aG Developers Alice
```
```
sudo usermod -aG Developers Charlie
```
```
sudo usermod -aG Designers Bob
```
```
sudo usermod -aG HR Dave
```
```
sudo usermod -aG HR Eve
```






