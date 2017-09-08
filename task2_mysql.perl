#!/usr/bin/perl
# Author: Leo Chang
# Date: Fri Sep  8 15:23:38 CST 2017
# Version: task2.1.0
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

my $sth3 = $dbh->prepare("SELECT * FROM cookbook");

$sth3->execute() or die "Couldn't execute statement: " . $sth3->errstr;

print "========================\n";
print "MySQL Table \"$targetTableName\":\n";
print "========================\n";
print "name day temp\n";
print "-------------\n";
$tempAccumulation = 0.0;
$count = 0;
while ( my @row = $sth3->fetchrow_array() ) {
  print "@row\n";
  $tempAccumulation = $tempAccumulation + $row[2];
  ++$count;
}
print "========================\n";
$tempAverage = $tempAccumulation / $count;
print STDOUT "The average of column \"temp\" is $tempAverage (= $tempAccumulation / $count) \n";

$dbh->disconnect();
