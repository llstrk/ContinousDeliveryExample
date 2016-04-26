configuration Default {
	Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node "WebServer" {
	    WindowsFeature TelnetClient {
		    Name   = "Telnet-Client"
		    Ensure = "Present"
	    }
        WindowsFeature IIS {
            Name   = "Web-Server"
            Ensure = "Present"
        }
    }
}