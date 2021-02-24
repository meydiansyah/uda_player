

<?php 

	include_once '../conn.php';

	if($_SERVER['REQUEST_METHOD'] == "POST"){

		$data = array();
		$user_id = $_POST['user_id'];

	    $query = mysqli_query($conn, "SELECT count(user_id) as total_harian, created_at FROM recent_opens where user_id = '$user_id' group by created_at");

		while ($row = mysqli_fetch_assoc($query)) {
			$data[] = $row;
		}

		echo json_encode($data);
	}
 ?>


