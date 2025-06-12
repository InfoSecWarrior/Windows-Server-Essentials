
# ➤ DHCP Server

A **DHCP (Dynamic Host Configuration Protocol) server** is a network service that automatically assigns IP addresses and other network configuration parameters to client devices. This eliminates the need for manual network configuration, ensuring seamless connectivity.

---

### ➤ Network Requirements

* **Static IP for DHCP Server**:
  The DHCP server must have a static IP address to reliably manage IP allocations.

  ```
  IP Address  : 10.0.2.15  
  Subnet Mask : 255.255.255.0  
  Gateway     : 10.0.2.2  
  ```

* **Subnet and IP Pool**:
  Define a range of IP addresses that the DHCP server can assign dynamically to clients.

* **Gateway and DNS Configuration**:
  The DHCP server should provide the default gateway and DNS server details to clients as part of the IP lease process.

---

## ➤ DORA Process (DHCP Lease Allocation Steps)

The **DORA process** is the four-step mechanism used by DHCP servers to assign IP addresses to clients:

1. **Discovery (D)** –
   The client broadcasts a **DHCP Discover** message to locate available DHCP servers.

   ```
   Source IP      : 0.0.0.0  
   Destination IP : 255.255.255.255  
   Source MAC     : [Client MAC]  
   Destination MAC: ff:ff:ff:ff:ff:ff  
   Client Port    : UDP 68  
   Server Port    : UDP 67  
   ```

2. **Offer (O)** –
   The DHCP server replies with a **DHCP Offer**, proposing an available IP address and configuration parameters.

3. **Request (R)** –
   The client sends a **DHCP Request** message to confirm acceptance of the offered IP.

4. **Acknowledgment (A)** –
   The server responds with a **DHCP ACK**, finalizing the lease and assigning the IP officially.

---

## ➤ DHCP Starvation Attack

A **DHCP starvation attack** is a Denial-of-Service (DoS) technique in which an attacker floods the DHCP server with fake requests using spoofed MAC addresses, exhausting all available IP addresses in the pool.

---

### ➤ How It Works

1. The attacker uses tools like **Yersinia** or **DHCP Gobbler** to generate fake **DHCP Discover** messages with unique (spoofed) MAC addresses.
2. The DHCP server assigns an IP address for each request until the pool is depleted.
3. Legitimate users are unable to receive an IP address, resulting in denial of network access.

---

### ➤ Prevention & Mitigation

 **Enable DHCP Snooping**
  Allows DHCP responses only from trusted sources.

 **Configure Port Security**
  Restricts the number of MAC addresses that can connect through a single switch port.

 **Implement Rate Limiting**
  Controls the number of DHCP requests a port can send per second.

 **Use 802.1X Authentication**
  Ensures only authenticated devices can request network access and obtain IP addresses.

---

