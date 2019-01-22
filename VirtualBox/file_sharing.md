### 1. Add shared folder

With the Virtual Machine powered off and selected in VirtualBox, go to:
- Machine > Settings ... > Shared Folders
- For “Folder Path”, click the icon to browse for the folder you want to share.
- For “Folder Name”, enter a name to describe the share.
- Check auto-mount
Click “OK” and start the virtual machine again.
Create a mount point which is basically an empty folder.

### 2. Add a shared folder on macos and allow everyone to Read nad Write

### 3. Install VirtualBox guest additions following instructions below:

https://websiteforstudents.com/installing-virtualbox-guest-additions-on-ubuntu-18-04-beta/

#### 3.1 (Ubuntu 16)

You have to add yourself to the shared folders group in the Ubuntu guest.
```
sudo adduser [your-user-name] vboxsf
```
### 4. Result

The share folder should become visible on the Desktop of the virtual machine
