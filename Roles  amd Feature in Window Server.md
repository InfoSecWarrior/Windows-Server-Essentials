
# **1. Roles in Windows Server**

1. **Active Directory Domain Services (AD DS)**

   * Manages domain authentication, user accounts, and group policies.
   * Provides **Single Sign-On (SSO)** and centralized identity management.

2. **DNS Server**

   * Resolves domain names into IP addresses.
   * Critical for **Active Directory** and internal/external name resolution.

3. **DHCP Server**

   * Dynamically assigns IP addresses to devices.
   * Minimizes manual configuration and avoids IP conflicts.

4. **File and Storage Services**

   * Manages file sharing, storage pools, and access control.
   * Includes components like **File Server**, **iSCSI Target Server**, **Storage Spaces**, etc.

5. **Web Server (IIS - Internet Information Services)**

   * Hosts websites, web applications, and FTP services.
   * Supports **ASP.NET**, **PHP**, **HTML**, and other web technologies.

6. **Remote Desktop Services (RDS)**

   * Provides remote access to desktops and applications.
   * Includes roles like **RD Gateway**, **RD Session Host**, **RD Web Access**, etc.

7. **Network Policy and Access Services (NPAS)**

   * Manages VPN, RADIUS authentication, and network access control.
   * Supports **802.1X** for secure wired/wireless access.

9. **Windows Server Update Services (WSUS)**

   * Distributes Microsoft updates within the local network.
   * Reduces external bandwidth usage and centralizes patch management.

10. **Active Directory Certificate Services (AD CS)**

    * Issues and manages digital certificates for authentication and encryption.
    * Used in **SSL/TLS**, **VPN**, **email security**, and **smart cards**.

11. **Active Directory Federation Services (AD FS)**

    * Provides **SSO** across trusted domains and cloud services.
    * Integrates with **Azure AD**, **Office 365**, and third-party applications.

12. **Active Directory Rights Management Services (AD RMS)**

    * Secures sensitive data using encryption and usage policies.
    * Works with Microsoft Office, SharePoint, and custom apps.

---

# **2. Features in Windows Server**

A **feature** is an optional capability that supports or enhances server roles.

### **Common Windows Server Features:**

1. **Failover Clustering**

   * Enables high availability by grouping servers into a cluster.
   * Used with services like **Hyper-V**, **SQL Server**, and **File Server**.

2. **Windows Server Backup**

   * Provides tools for backing up and restoring system data.

3. **BitLocker Drive Encryption**

   * Encrypts entire disk volumes to protect data at rest.

4. **Network Load Balancing (NLB)**

   * Distributes traffic evenly across servers to improve availability and performance.

5. **Telnet Client**

   * Allows command-line communication with remote hosts via Telnet protocol.

6. **Windows Defender Features**

   * Built-in antivirus, antimalware, and threat protection.

7. **Simple TCP/IP Services**

   * Offers legacy network tools like echo, daytime, and chargen.

8. **Windows PowerShell & PowerShell Desired State Configuration (DSC)**

   * Provides powerful scripting and configuration management tools.

9. **SMB Direct**

   * Supports high-performance, low-latency file sharing using RDMA-enabled NICs.

10. **Remote Server Administration Tools (RSAT)**

    * Enables remote management of roles and features from another Windows machine.

---
