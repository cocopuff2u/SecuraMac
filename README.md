![SecuraMac logo](images/github-header-image.png)

`SecuraMac` simplifies macOS security, offering quick and effective tools to fortify your system and ensure protection.


**Installation Options**
---

1. 

2. 


**Configuration Options**
---

1. Firewall Rules

    + Turn on Firewall?
        - This helps protect your Mac from being attacked over the internet.
    + Turn on stealth mode?
        - Your Mac will not respond to ICMP ping requests or connection attempts from closed TCP and UDP networks.

2. Logging Rules

    + Set Audit Log Files To Not Contain Access Control List?
        - Access control lists will no longer be included in the log files.
    + Set Audit Log Folders To Not Contain Access Control List?
        - Access control lists will no longer be included in the log folders.
    + Audit All Administrative Action Events?
        - Administrative action events will now be audited for all activities.
    + Audit All Log On Log Out?
        - Audits all log on and log out actions in the audit log.
    + Enable_Security_Auditing?
        - This rule checks if the security auditing service is running and if the audit control file exists.
    + Configure System To Shutdown Upon Audit Failure?
        - This rule ensures that the system is configured to shut down automatically if an audit failure occurs.
    + Set Audit Log Files To Be Owned By Root?
        - This rule checks that all audit log files are owned by the root user.
    + Set Audit Log Folders To Be Owned By Root?
        - This rule checks that all audit log folders are owned by the root user.
    + Set Audit Log Files To Be Group Owned By Wheel?
        - This rule ensures that audit log files are group-owned by the wheel group.
    + Set Audit Log Folders To Be Group Owned By Wheel?
        - This rule checks that all audit log folders are group-owned by the wheel group.
    + Set Audit Log Files Mode 440 or Less Permissive?
        - This rule checks that audit log files have permissions set to 440 or less permissive.
    + Set Audit Log Folder Mode 700 or Less Permissive?
        - This rule checks that audit log folders have permissions set to 700 or less permissive.
    + Set To Audit All Deletion Of Object Attributes?
        - This rule ensures that deletion of object attributes is audited.
    + Audit All Changes Of Object Attributes?
        - This rule ensures that changes to object attributes are audited.
    + Audit All Failed Read Actions?
        - This rule ensures that all failed read actions are audited.
    + Audit All Failed Write Actions?
        - This rule ensures that all failed write actions are audited.
    + Audit All Failed Program Executions?
        - This rule ensures that all failed program executions are audited.
    + Audit Retention Set To 7 Days?
        - This rule ensures that audit log retention is set to 7 days.
    + Audit Capacity Warning?
        - This rule checks that a minimum free space of 25% is set for audit logs.
    + Audit Failure Notification?
        - This rule ensures that audit failures are logged with a notification.
    + Audit All Authorization Authentication Events?
        - This rule checks if all authorization and authentication events are being audited.
    + Configure Audit Control Group To Wheel?
        - This rule ensures that the audit control file group is set to wheel.
    + Configure Audit Control Owner To Root?
        - This rule ensures that the audit control file is owned by root.
    + Configure Audit Control To Mode 440 or Less Permissive?
        - This rule ensures that the audit control file has permissions set to 440 or less permissive.
    + Configure Audit Control To Not Contain Access Control Lists?
        - This rule ensures that the audit control file does not contain access control lists.
    + Configure Apple System Log Files To Be Owned By Root and Group To Wheel?
        - This rule ensures that Apple system log files are owned by root and the group is set to wheel.
    + Configure Apple System Log Files To Mode 640 Or Less Permissive?
        - This rule ensures that Apple system log files have permissions set to 640 or less permissive.
    + Configure System Log Files To Be Owned By Root and Group To Wheel?
        - This rule ensures that system log files are owned by root and the group is set to wheel.
    + Configure System Log Files To Mode 640 Or Less Permissive?
        - This rule ensures that system log files have permissions set to 640 or less permissive.
    + System Log Retention To 365 Days?
        - This rule ensures that system log retention is set to 365 days.
    + Configure Sudoers Timestamp Type?
        - This rule ensures that the sudoers timestamp type is set correctly.