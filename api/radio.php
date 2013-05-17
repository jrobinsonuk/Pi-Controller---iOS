<?php

/*
	Script to run Radio on Raspberry Pi
	
	
	Actions
		start
		station
		
	Values
	
*/


function return_success() {
	echo 'success';
	//echo json_encode(array("success"=>"200"));
	exit;
}

function return_fail() {
	echo 'failed';
	//echo json_encode(array("error"=>"400"));
	exit;
}

function set_station($station = 1) {
	if ($station < 1 || $station > 4) return_fail();
	
	system("mpc play $station");
}



if (isset($_GET['action']) && !empty($_GET['action'])) {
	
	switch ($_GET['action']) {
		case "start":
			
			system("mpc play");
			
			break;
			
		case "stop":
			
			system("mpc stop");
			
			break;
			
		case "station":
		
			if (isset($_GET['value']) && is_numeric($_GET['value'])) {
				$station = $_GET['value'];
				set_station($station);
			}
			
			break;
			
		case "playing":
		
			system("mpc current");
			
			break;
			
		case "volume":
		
			$volume = "";
			if (isset($_GET['value']) && is_numeric($_GET['value'])) {
				$volume = (int)$_GET['value'];
			}
			system("mpc volume $volume");
			
			break;
			
		case "current_details":
		
			system("mpc current");
			echo ' {} ';
			system("mpc volume");
			
			break;
		
		default:
			return_fail();
		
	}
	
} else {
	return_fail();
}

?>