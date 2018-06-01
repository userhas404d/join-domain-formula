# Check local system for domain join status.
# Print results in stalt stack expected format.
[CmdLetBinding()]
Param(
    [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
    [String[]]
    $DomainFQDN
    )

    if ( ( (Get-WmiObject Win32_ComputerSystem).partofdomain ) -eq $True )
    {
      $domain = (Get-WmiObject Win32_ComputerSystem).domain;
      if ( $domain -eq $DomainFQDN )
      {
        Write-Host "changed=no comment=`"System is joined already to the correct domain [$domain].`" domain=$domain";
      }
      else
      {
        throw "System is joined to another domain [$domain]. To join a
          different domain, first remove it from the current domain."
      }
    }
    else
    {
      Write-Host "changed=yes comment=`"System is not domain joined. Proceeding..`"";
    }
