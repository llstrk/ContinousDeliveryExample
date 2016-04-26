configuration Default {
	Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node "WebServer" {
	    WindowsFeature TelnetClient {
		    Name   = "Telnet-Client"
		    Ensure = "Absent"
	    }
        WindowsFeature IIS {
            Name   = "Web-Server"
            Ensure = "Absend"
        }
    }
}