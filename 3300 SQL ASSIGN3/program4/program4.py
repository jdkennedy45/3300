import sys
import MySQLdb

if len(sys.argv) != 5:
    print "Correct usage is HOST, DB, USER, PW"
    sys.exit(1)

try: 
    con=MySQLdb.connect(host=sys.argv[1], user=sys.argv[3], passwd=sys.argv[4], db=sys.argv[2])

except MySQLdb.Error, e:
    print "Error %d: %s" % (e.args[0])
    sys.exit(1)

cursor=con.cursor()
cursor.execute(
'''
create table grades(
tnumber char(8), 
courseid char(7), 
semester char(1), 
year numeric(4,0), 
grade char(1), 
foreign key (tnumber) REFERENCES students(tnumber) ON DELETE CASCADE
) ENGINE=INNODB;
''')

cursor.execute(
'''
INSERT INTO grades
(tnumber, courseid, semester, year, grade) 
VALUES
('00003256', 'CSC4300', 'F', 2013, 'A'), 
('00012345', 'MAT1910', 'F', 2011, 'B'), 
('00012345', 'MAT1910', 'S', 2012, 'A'), 
('00012345', 'CSC2110', 'S', 2010, 'D'), 
('00012345', 'CSC2110', 'F', 2010, 'D'), 
('00001423', 'BIO1010', 'S', 2014, 'D'), 
('00015366', 'CSC2110', 'F', 2013, 'C'), 
('00015366', 'CSC2110', 'S', 2014, 'C'), 
('00015366', 'CSC2110', 'F', 2013, 'B'), 
('00003256', 'CSC4100', 'S', 2012, 'A'),
('00003256', 'CSC2110', 'F', 2015, 'A')
''')

cursor.execute("select * from grades")

print ("------------------------------------------------------------")
print ("TNumber      CourseID    Semester     Year        Grade")
print ("------------------------------------------------------------")
data = cursor.fetchall()
for row in data:
    print "%10s| %10s| %10s| %10d| %10s|" % (row[0], row[1], row[2], row[3], row[4])

con.close()
cursor.close()

