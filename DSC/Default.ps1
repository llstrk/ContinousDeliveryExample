configuration Default {
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Script ConfigureWinRM {
        GetScript = {
            @{}
        }
        TestScript = {
            $listener = Get-ChildItem WSMan:\localhost\Listener | where {$_.Keys.Contains('Transport=HTTPS')}
            if ($listener) {
                return $true
            }
            else {
                return $false
            }
        }
        SetScript = {
            Enable-PSRemoting -Force

            New-NetFirewallRule -Name "WinRM HTTPS" -DisplayName "WinRM HTTPS" -Enabled True -Profile Any -Action Allow -Direction Inbound -LocalPort 5986 -Protocol TCP -ErrorAction SilentlyContinue
            $thumbprint = (New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My).Thumbprint

            $cmd = "winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname=""$env:computername""; CertificateThumbprint=""$thumbprint""}"
            cmd.exe /C $cmd
        }
    }
}