#include <mysql.h>
#include <stdio.h>
#include <stdlib.h>

void finish_with_error(MYSQL *con)
{
	fprintf(stderr, "%s\n", mysql_error(con));
  mysql_close(con);
	exit(1);
}

int main(int argc, char **argv)
{
	if (argc != 5)
	{
		fprintf(stderr, "USAGE: host database user password \n");
	}
	
	MYSQL *con = mysql_init(NULL);

	if (mysql_real_connect(con, argv[1], argv[3], argv[4], argv[2], 0, NULL, 0) == NULL)
	{
		finish_with_error(con);
	}

	if (mysql_query(con, 
			"INSERT INTO students"
			"(tnumber, firstname, lastname, dateofbirth)"
			" VALUES"
			"('00003256', 'John', 'Doe', '1970-07-15'),"
			"('00001423', 'Mary', 'Smith', '1992-01-01'),"
			"('00015366', 'William', 'Williamson', '1991-05-23'),"
			"('00012345', 'Katie', 'Did', '1992-09-27')"))
	{
		finish_with_error(con);
	}

	if (mysql_query(con, "SELECT * from students"))
	{
		finish_with_error(con);
	}

	MYSQL_RES *result = mysql_store_result(con);
	
	if(result == NULL)
	{
		finish_with_error(con);
	}

	int num_fields = mysql_num_fields(result);
	MYSQL_ROW row;

	fprintf(stderr, "      -----------------------------------------------------------------\n");
	fprintf(stderr, "        TNUmber	    FirstName	    LastName	    DateOfBIrth \n");
	fprintf(stderr, "      -----------------------------------------------------------------\n");
	
	while ((row = mysql_fetch_row(result)))
	{
		for (int i = 0; i < num_fields; i++)
		{
			printf("%15s|", row[i] ? row[i]  : "NULL");
		}
			printf("\n");
	}
	
	mysql_free_result(result);

	mysql_close(con);
	exit(0);

}



	
