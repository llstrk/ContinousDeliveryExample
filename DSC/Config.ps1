configuration Config {
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "WebServer" {
        WindowsFeature TelnetClient {
            Name   = "Telnet-Client"
            Ensure = "Present"
        }
        WindowsFeature WebServer {
            Name   = "Web-Server"
            Ensure = "Present"
        }
    }
}