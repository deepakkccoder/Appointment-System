#!C:\Perl64\bin\perl.exe -wT

print "Content-type : text/json\n\n";
use strict;
use CGI;
use DBI;
use JSON;
my $cgi = new CGI;

my $driver="SQLite";
my $database="apex.db";
my $dsn="DBI:$driver:dbname=$database";
my $userid="";
my $password="";

#DATABASE CONNECTION
my $db_handle = DBI -> connect($dsn,$userid,$password,{RaiseError=>1});


#SEARCH TEXT
my $txtSearch = $cgi->param('searchData');
 
#SELECTING VALUE FROM DATABASE
my $query=qq(select datetime,description from record where description like ?);
my $query_handle = $db_handle->prepare($query);

#EXECUTE THE QUERY
$query_handle->execute($txtSearch."%") or die $DBI::errstr;

my @output = $query_handle->fetchrow_hashref;

$db_handle->disconnect();
#CONVERTING TO JSON
print to_json(\@output);


