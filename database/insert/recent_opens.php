<?php 
	include '../conn.php';


    if($_SERVER['REQUEST_METHOD'] == "POST"){
	    $response = array();

	    $videoId = mysqli_real_escape_string($conn, $_POST['video_id']);
	    $userId = mysqli_real_escape_string($conn, $_POST['user_id']);
	    

	    $query = "INSERT INTO recent_opens VALUES (NULL, '$videoId', '$userId', NOW(), CURRENT_TIME())";

    	$results = mysqli_query($conn, $query);

	    if($results > 0){
	        $response['value'] = 0;
	        $response['message'] = 'Success add to recent opens';
	        echo json_encode($response);

	    } else{
            $response['value'] = 1;
            $response['message'] = "Failed";
            echo json_encode($response);
	    }	
    }

 ?>