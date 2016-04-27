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
    }
}