<?php
	$con = mysql_connect($argv[1], $argv[3], $argv[4])
		or die('Could not connect: ' . mysql_error());
	echo 'Connected Successfully';
	mysql_select_db($argv[2]) or die('Could not select db');

	$query = 'select tnumber, courseid ' .
					 'from grades ' .
					 'group by tnumber, courseid ' .
					 'having count(*) > 1';
	$result = mysql_query($query) or die ('Query failed: ' .
																				mysql_error());
	
	echo "<table border=\"1\">\n";
	while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
		echo "\t<tr>\n";
		foreach ($line as $col_value) {
			echo "\t\t<td>$col_value</td>\n";
		}
		echo "\t</tr>\n";
	}
	echo "</table>\n";
	mysql_free_result($result);
	mysql_close($con);

?>
