## Windows Tools

Install chocolatey from the instructions given in the link below.

https://chocolatey.org/docs/installation

or follow the steps below to install chocolatey

1. Search for powershell on your computer, right click on it and select ``` Run as administrator```.
2. Next we check the policy to make sure we are not restricted by running;

```
Get-ExecutionPolicy
```
You should see ```AllSigned```
If it returns ```Restricted```, then run 
```
Set-ExecutionPolicy AllSigned 
```
or 
```
Set-ExecutionPolicy Bypass -Scope Process
```

2. Now run the following to install choco

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### You now have choco installed on your computer. We will now install the rest of the tools using choco
```
choco install virtualbox --version=7.0.10 -y
```

```
choco install vagrant --version=2.3.7 -y
```

```
choco install git -y
```

```
choco install vscode -y
```

```
choco install sublimetext3.app -y
```


## MacOS Tools

Install brew from the instructions given in the link below.

https://brew.sh/

After installing homebrew Create a file in users home directory with name .curlrc with content “-k” (-k without quotes and give a new line character after -k.)

Steps:

1. OpenTerminal
2. Execute below command

```
echo -k > ~/.curlrc
```

3. Execute below command to see -k in file ~/.curlrc
```
cat ~/.curlrc
```
Run all the below commands in Terminal

### (virtualbox command is not For MacOs M1/M2)
```
brew install --cask virtualbox
```
```
brew install --cask vagrant
```
```
brew install --cask vagrant-manager
```
```
brew install git
```
```
brew install openjdk@11
```
```
sudo ln -sfn $HOMEBREW_PREFIX/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```
```
exec zsh -l
```
```
brew install --cask visual-studio-code
```
```
brew install --cask intellij-idea
```
```
brew install --cask intellij-idea-ce
```
```
brew install --cask sublime-text
```
```
brew install --cask sublime-text
```
```
brew install awscli
```
