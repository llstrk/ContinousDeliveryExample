configuration Default {
	Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node "WebServer" {
	    WindowsFeature TelnetClient {
		    Name   = "Telnet-Client"
		    Ensure = "Present"
	    }
    }
}