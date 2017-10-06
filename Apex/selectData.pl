#!C:\Perl64\bin\perl.exe -wT

print "Content-type : text/json\n\n";
use strict;
use DBI;
use JSON;

#DATABASE SETUP
my $driver="SQLite";
my $database="apex.db";
my $dsn="DBI:$driver:dbname=$database";
my $userid="";
my $password="";

#DATABASE OONNECTION
my $db_handle = DBI -> connect($dsn,$userid,$password,{RaiseError=>1});

my @output;

#SELECT VALUE FROM DATABASE
my $query=qq(select datetime,description from record);
my $query_handle = $db_handle->prepare($query);

#EXECUTE THE QUERY
$query_handle->execute() or die $DBI::errstr;

while ( my $row = $query_handle->fetchrow_hashref ){
    push @output, $row;
}
$db_handle->disconnect();
#CONVERTING TO JSON
print to_json(\@output);


