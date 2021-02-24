<?php 
	include 'conn.php';


    if($_SERVER['REQUEST_METHOD'] == "POST"){
	    $response = array();

	    $username = mysqli_real_escape_string($conn, $_POST['username']);
	    $email = mysqli_real_escape_string($conn, $_POST['email']);
    	$password = md5(mysqli_real_escape_string($conn, $_POST['password']));
	    
	    $res_username = mysqli_fetch_array(mysqli_query($conn, "select username from user where username = '$username'"));
	    $res_email = mysqli_fetch_array(mysqli_query($conn, "select email from user where email = '$email'"));

	    if(isset($res_username)) {
	    	$response['value'] = 2;
	    	$response['message']= 'Username is already taken';
	    	echo json_encode($response);
	    } else if(isset($res_email)) {
			$response['value'] = 3;
	    	$response['message']= 'Email is already taken';
	    	echo json_encode($response);
	    } else {
	    	$query = "INSERT INTO user VALUES (NULL, '$username', '$email', '$password', NOW())";

	    	$results = mysqli_query($conn, $query);

		    if($results > 0){
		        $response['value'] = 0;
		        $response['message'] = 'Register Success';
		        echo json_encode($response);

		    } else{
	            $response['value'] = 1;
	            $response['message'] = "Register Failed";
	            echo json_encode($response);
		    }	
	    }
    }

 ?>