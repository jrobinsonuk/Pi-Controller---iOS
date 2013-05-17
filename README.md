# Pi Controller

Pi Controller allows you easily manage features installed on your Raspberry Pi. The primary function of this application/server combination is to manage Linux mpc audio player for radios.



## Requirements

*	Raspberry Pi setup as a webserver with PHP.



## Installation

1.	Copy files in 'api' to somewhere within the website folder of your system
2.	Install mpc and add your radio stations

>
	* sudo apt-get install mpd mpc
	* Edit /etc/mpd.conf to:


	audio_output {
		type            "alsa"
	    name            "My ALSA Device"
	    device          "hw:0,0"         # optional
	    #format          "44100:16:2"     # optional
	    #mixer_device    "default"        # optional
	    #mixer_control   "PCM"            # optional
	    #mixer_index     "0"              # optional
	}

>
	* cat station.m3u
	* mpc add [cat result]
	* mpc play


3.	Install the app on your iOS device (iPad and iPhone supported)
4.	Set the base URL for your Raspberry Pi in the settings tab. This is the URI location to the folder your 'radio.php' file is located. Be sure to include a '/' at the end.




## Usage
Not for commercial use or resale.



#### Markup fail - sorry