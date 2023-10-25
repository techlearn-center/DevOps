## 1. User Creation:
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

Verify if groups have been created by checking the /etc/group file or using commands like ```getent``` or ```groups```. Here's how:
```
cat /etc/group
```

To search for a specific group, you can use grep. For example, to search for the group named "Developers":

```
grep '^Developers:' /etc/group
```

The getent command displays entries from databases supported by the Name Service Switch libraries, which includes the group database.

```
getent group Developers
```

If the group "Developers" exists, this command will return its details. If not, there won't be any output.

Also, ```groups``` command followed by a username helps to see which groups a user is a member of. 
```
groups Eve
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

## Directory Setup:
### Create a directory for each group in /home/department/ (e.g., /home/department/Developers).
```
sudo mkdir -p /home/department/Developers
```
```
sudo mkdir -p /home/department/Designers
```
```
sudo mkdir -p /home/department/HR
```

### Ensure only users of a group can access their respective directory. For instance, only Alice and Charlie should access the Developers directory.
```
sudo chown :Developers /home/department/Developers
sudo chmod 770 /home/department/Developers
```


```
sudo chown :Designers /home/department/Designers
sudo chmod 770 /home/department/Designers
```

```
sudo chown :HR /home/department/HR
sudo chmod 770 /home/department/HR
```

The command ```sudo chown :HR /home/department/HR``` is used to change the group ownership of the directory /home/department/HR to the group HR.


To check if the HR group has group ownership of the /home/department/HR directory, you can use the ls command with the -l option.
```
ls -ld /home/department/HR
```
Now only the members of each group can access their respective directories. For instance, only Alice and Charlie can access the /home/department/Developers directory.



## File Management:
### In each department directory, create a README.txt file that contains a brief description of the department.

You'll need to create a README.txt file in each directory (Developers, Designers, HR etc.). 
```
echo "This is the Developers department." > /home/department/Developers/README.txt
```
```
echo "This is the Designers department." > /home/department/Designers/README.txt
```
```
echo "This is the HR department." > /home/department/HR/README.txt
```

### Ensure that only group members can read and write to the file, but others should not have any access.

To ensure that only the group members can read (r) and write (w) to the file, and others should not have any access. To set these permissions, you can use the chmod command:

#### For Developers
```
chmod 660 /home/department/Developers/README.txt
```

#### For Designers
```
chmod 660 /home/department/Designers/README.txt
```


#### For HR
```
chmod 660 /home/department/HR/README.txt
```


After executing these commands, only the group members will be able to read and write to the README.txt files in their respective department directories, while others won't have any access.

## Advanced Task (for bonus points):
### Create a shared directory at /home/shared.
### All users should be able to read files in this directory, but only members of the HR group should be able to create files or directories here. However, they shouldn't be able to delete files owned by others.

First, you'll create the directory at /home/shared:
```
sudo mkdir /home/shared
```
You want all users to read files and the HR group to write, so you would initially think of 755 (read and execute for all, write for owner).
But since we want the HR group to write, it would be 775 (write for group as well):
```
sudo chmod 775 /home/shared
```
You want the HR group to have special permissions on this directory:

```
sudo chown :HR /home/shared

```

The sticky bit is a permission that, when set on a directory, allows only the owner of a file (or directory) within that directory to delete or rename their own files. 
Everyone else, even if they have write permissions on the directory, cannot delete or rename files owned by others.

```
sudo chmod +t /home/shared
```

If you list the directory using ```ls -ld /home/shared```, you should now see a permission string that looks like **drwxrwxr-t**, where the *t* at the end represents the sticky bit.

Now, all users can read files in **/home/shared**, members of the HR group can create files or directories, but they cannot delete or rename files owned by others due to the sticky bit.

