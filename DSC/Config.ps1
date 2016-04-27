configuration Default {
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "WebServer" {
        WindowsFeature TelnetClient {
            Name   = "Telnet-Client"
            Ensure = "Absent"
        }
        WindowsFeature WebServer {
            Name   = "Web-Server"
            Ensure = "Present"
        }
        Script WebSite {
            GetScript = {@{}}
            TestScript = {
                $content = Get-Content -Path C:\inetpub\wwwroot\iisstart.htm -ErrorAction SilentlyContinue
                if ($content -eq $null) {
                    return $false
                }
                else {
                    $content -like '*DSC Agent ID*'
                }
            }
            SetScript = {
                $path    = "C:\inetpub\wwwroot\iisstart.htm"
                $content = "<html><p>DSC Agent ID: $((Get-DscLocalConfigurationManager).AgentID)</p><p>OS Version: $((Get-CimInstance -ClassName Win32_OperatingSystem).Version)</p></html>"
                $content | Out-File -FilePath $path -Force
            }
            DependsOn = "[WindowsFeature]WebServer"
        }
    }
}