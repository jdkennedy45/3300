#!/bin/bash
isql-fb -user SYSDBA -password coursework "localhost:/home/coursework/employee.fdb" < "problem$1.sql"
