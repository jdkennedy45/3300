if {[catch {
	package require tdbc::mysql
	tdbc::mysql::connection create con -user [lindex $argv 2] -database [lindex $argv 1] -password [lindex $argv 3]

	set stmt [con prepare {select * from students where lastname like "D%"}]
	set results [$stmt allrows]
	puts "      ---------------------------------------------------------------"
	puts "        TNUmber	    FirstName	    LastName	    DateOfBIrth  "
	puts "      ---------------------------------------------------------------"
	foreach row $results {
			foreach {col_name col_val} $row {
					puts -nonewline [format "%15s|" $col_val]
				}
			puts ""
		}
	con close
} errmsg]} {
		puts $errmsg
}

