<?php 
	include_once 'conn.php';

	if($_SERVER['REQUEST_METHOD'] == "POST"){
	    $response = array();
	    $name = $_POST['username'];
	    $password = md5($_POST['password']);
	    
	    $cekUsername = "SELECT * FROM user WHERE username='$name' ";
	    $cekPassword = "SELECT * FROM user WHERE password = '$password'";


	    $result = mysqli_fetch_array(mysqli_query($conn, $cekUsername));

	    if(isset($result)){

			$response['value'] = 1;
	        $response['message'] = 'Username terdaftar';

	        $cek = mysqli_fetch_array(mysqli_query($conn, $cekPassword));
	        
	        if(isset($cek)) {
				$response['value'] = 2;
	        	$response['message'] = 'Password dan email terdaftar';

	        	$response['id'] = $result['id'];
		        $response['username'] = $result['username'];
		        $response['email'] = $result['email'];
		        $response['created_at'] = $result['created_at'];

	        } else {
				$response['value'] = 3;
		        $response['message'] = 'password tidak terdaftar';
	        }

	        echo json_encode($response);



	    } else{
            $response['value'] = 0;
            $response['message'] = "login gagal ! Periksa Username anda";
            echo json_encode($response);
        }

	    
    }

 ?>
