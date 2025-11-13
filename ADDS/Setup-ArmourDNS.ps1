<#
.SYNOPSIS
    Creates both forward and reverse DNS zones for 'armour.local' and adds standard DNS records.

.DESCRIPTION
    This script creates:
    - Forward lookup zone: armour.local
    - Reverse lookup zone: 192.168.1.0/24 (AD-integrated)
    - A, MX, CNAME, SRV, and PTR records

.NOTES
    Run as Administrator on a DNS server.
    Requires the DnsServer module.
#>

Import-Module DnsServer -ErrorAction Stop

# ------------------------------
# Variables
# ------------------------------
$zoneName = "armour.local"
$reverseZone = "1.168.192.in-addr.arpa"
$domainController = "dc01"
$ipAddress = "192.168.1.51"

Write-Host "`n=== DNS Configuration for $zoneName ===" -ForegroundColor Cyan

# ------------------------------
# Create Forward Lookup Zone
# ------------------------------
if (-not (Get-DnsServerZone -Name $zoneName -ErrorAction SilentlyContinue)) {
    Write-Host "Creating Forward Lookup Zone: $zoneName ..."
    Add-DnsServerPrimaryZone -Name $zoneName -ReplicationScope "Domain" -PassThru -Verbose
} else {
    Write-Host "Forward Lookup Zone '$zoneName' already exists. Skipping..."
}

# ------------------------------
# Create Reverse Lookup Zone
# ------------------------------
if (-not (Get-DnsServerZone -Name $reverseZone -ErrorAction SilentlyContinue)) {
    Write-Host "Creating Reverse Lookup Zone: $reverseZone ..."
    Add-DnsServerPrimaryZone -NetworkId "192.168.1.0/24" -ReplicationScope "Domain" -PassThru -Verbose
} else {
    Write-Host "Reverse Lookup Zone '$reverseZone' already exists. Skipping..."
}

# ------------------------------
# A Records
# ------------------------------
$records = @(
    @{ Name = "@"; IPv4 = $ipAddress },
    @{ Name = $domainController; IPv4 = $ipAddress },
    @{ Name = "mail"; IPv4 = $ipAddress }
)

foreach ($rec in $records) {
    $existing = Get-DnsServerResourceRecord -ZoneName $zoneName -Name $rec.Name -RRType "A" -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Host "Updating A record: $($rec.Name).$zoneName → $($rec.IPv4)"
        Remove-DnsServerResourceRecord -ZoneName $zoneName -Name $rec.Name -RRType "A" -Force
    } else {
        Write-Host "Adding A record: $($rec.Name).$zoneName → $($rec.IPv4)"
    }
    Add-DnsServerResourceRecordA -Name $rec.Name -ZoneName $zoneName -IPv4Address $rec.IPv4 -Verbose
}

# ------------------------------
# SRV Records
# ------------------------------
Write-Host "Adding SRV records..."
Add-DnsServerResourceRecord -Srv -Name "_ldap._tcp" -ZoneName $zoneName -DomainName "$domainController.$zoneName" -Port 389 -Priority 0 -Weight 100 -Verbose
Add-DnsServerResourceRecord -Srv -Name "_kerberos._tcp" -ZoneName $zoneName -DomainName "$domainController.$zoneName" -Port 88 -Priority 0 -Weight 100 -Verbose

# ------------------------------
# CNAME Record
# ------------------------------
Write-Host "Adding CNAME record: www → $domainController.$zoneName"
$existingCNAME = Get-DnsServerResourceRecord -ZoneName $zoneName -Name "www" -RRType "CNAME" -ErrorAction SilentlyContinue
if ($existingCNAME) {
    Remove-DnsServerResourceRecord -ZoneName $zoneName -Name "www" -RRType "CNAME" -Force
}
Add-DnsServerResourceRecordCName -Name "www" -ZoneName $zoneName -HostNameAlias "$domainController.$zoneName" -Verbose

# ------------------------------
# MX Record
# ------------------------------
Write-Host "Adding MX record: mail.$zoneName (Preference 10)"
Add-DnsServerResourceRecordMX -Name "@" -ZoneName $zoneName -MailExchange "mail.$zoneName" -Preference 10 -Verbose

# ------------------------------
# PTR Record
# ------------------------------
try {
    $lastOctet = ($ipAddress.Split('.')[-1])
    Write-Host "Adding PTR record: $ipAddress → $domainController.$zoneName"
    Add-DnsServerResourceRecordPtr -Name $lastOctet -ZoneName $reverseZone -PtrDomainName "$domainController.$zoneName" -Verbose
} catch {
    Write-Warning "PTR record creation failed: $_"
}

Write-Host "`DNS zones and records configured successfully." -ForegroundColor Green
