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
        File WebSite {
            DestinationPath = "C:\inetpub\iisstart.htm"
            Contents  = "<html><p>DSC Agent ID: $((Get-DscLocalConfigurationManager).AgentID)</p><p>OS Version: $((Get-CimInstance -ClassName Win32_OperatingSystem).Version)</p></html>"
            Ensure    = "Present"
            DependsOn = "[WindowsFeature]WebServer"
        }
    }
}