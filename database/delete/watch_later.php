<?php 
	include '../conn.php';


    $response = array();

    $videoId = $_POST['video_id'];
    $userId = $_POST['user_id'];

    $query = "DELETE FROM watch_later WHERE video_id = '$videoId' and user_id = '$userId' ";

	$results = mysqli_query($conn, $query);

    if($results){
        $response['value'] = 0;
        $response['message'] = 'Success delete data';
        echo json_encode($response);

    } else{
        $response['value'] = 1;
        $response['message'] = "Failed";
        echo json_encode($response);
    }	


 ?>