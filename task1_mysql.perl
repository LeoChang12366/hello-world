#!/usr/bin/perl
# Author: Leo Chang
# Date: Fri Sep  8 15:23:38 CST 2017
# Version: task1.1.0
use warnings;
use DBI;

# MySQL database configuration
my $host = "sql3.freesqldatabase.com";
print "Server: $host\n";
print "Username: ";
chomp(my $username = <STDIN>);
print "Password: ";
chomp(my $password = <STDIN>);
my $db = $username;

print "Connecting to sql3.freesqldatabase.com ...\n\n";

my $dbh = DBI->connect("DBI:mysql:database=$db:host=$host", $username, $password) or die("Error connecting to the database: $DBI::errstr\n");

my $targetTableName = "cookbook";

my $sth0 = $dbh->prepare("DROP TABLE IF EXISTS $targetTableName");
$sth0->execute() or die "Couldn't execute statement: " . $sth0->errstr;

my $sth1 = $dbh->prepare("CREATE TABLE $targetTableName(name VARCHAR(20), day INT, temp FLOAT)");

$sth1->execute() or die "Couldn't execute statement: " . $sth1->errstr;

my $sth2 = $dbh->prepare("LOAD DATA LOCAL INFILE '../tabledata.csv' INTO TABLE cookbook FIELDS TERMINATED BY ',' IGNORE 1 LINES");

$sth2->execute() or die "Couldn't execute statement: " . $sth2->errstr;

my $sth3 = $dbh->prepare("SELECT * FROM cookbook");

$sth3->execute() or die "Couldn't execute statement: " . $sth3->errstr;

print "========================\n";
print "MySQL Table \"$targetTableName\":\n";
print "========================\n";
print "name day temp\n";
print "-------------\n";
while ( my @row = $sth3->fetchrow_array() ) {
  print "@row\n";
}
print "========================\n";

$dbh->disconnect();
