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
            TestScript = {$false}
            SetScript = {
                $path    = "C:\inetpub\iisstart.htm"
                $content = "<html><p>DSC Agent ID: $((Get-DscLocalConfigurationManager).AgentID)</p><p>OS Version: $((Get-CimInstance -ClassName Win32_OperatingSystem).Version)</p></html>"
                $content | Out-File -FilePath $path -Force
            }
            DependsOn = "[WindowsFeature]WebServer"
        }
    }
}