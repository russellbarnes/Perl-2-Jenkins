use XML::Writer;
use IO::File;

# Perl-2-Jenkins
# Save software test results in JUnit format for Jenkins.
# Russell Barnes, 2013.  See LICENSE file.

# Code to read text from a file, which may be useful for gathering test results:
#open(FILE, "<pathToFile") or warn "Cannot open file for reading.";
#$text = do{ local $/; <FILE>};
#close(FILE);

# Initialize the XML file
$XMLFilePath = "report.xml"; # The file name that will be added to the JUnit post-build step.  Remember to save it in the job's workspace.
my $XMLfile = IO::File->new(">$XMLFilePath");
my $XMLobject = XML::Writer->new(OUTPUT => $XMLfile, DATA_MODE => 1, DATA_INDENT => 8, ENCODING => 'us-ascii');
$XMLobject->xmlDecl();

# There is only ONE testsuites tag per results file.
$XMLobject->startTag('testsuites', 
				  'name' => "Test Results for $suitename");

	# There is no limit to testsuite tags.
	$XMLobject->startTag('testsuite', 
						'name' => $Package # Determines the 'Class' of the testcases in the Jenkins test report
						#'tests' => $PackageTotal, # Optional sum of tests
						#'failures' => $PackageFailures, # Optional sum of failures
						#'skipped' => $PackageSkipped, # Optional sum of skipped tests
						# Optional timestamp: Mon Jan 1 12:00:00 2013
						#'timestamp' => sprintf "%d-%02d-%02d %d:%d:%d", map { $$_[5]+1900, $$_[4]+1, $$_[3], $$_[2], $$_[1], $$_[0]} [localtime] 
	); 
						
		# There is no limit to testcase tags. Each represents one test in Jenkins:
		$XMLobject->startTag('testcase', 
							'name' => $TestName # The 'Test Name' in Jenkins
							#'classname' => $Package # Optional: determines the 'Package' in Jenkins (append a comma to the above line, too)
		);

			# Optionally print system-out and system-error here.  This will be displayed when you click on the test case in Jenkins:
			
			# I recommend applying the following filters to the text:
			#$testOut =~ s/[\x00-\x08\x0B-\x0C\x0E-\x1F]//g; # Filter out control characters, such as backspace, to avoid crashing the parser
			#$testOut =~ s/^\s*\n*//gm; # Filter out blank lines
			#$XMLobject->dataElement('system-out', $testOut); # 'Standard Output' in Jenkins

			# Including a standard-error element will automatically mark the test as a failure.
			#$testErr =~ s/[\x00-\x08\x0B-\x0C\x0E-\x1F]//g; # Filter out control characters, such as backspace, to avoid crashing the parser
			#$testErr =~ s/^\s*\n*//gm; # Filter out blank lines
			#$XMLobject->dataElement('system-err', $testErr); # Stderr
			
			# If the test was a failure, print this:
			#$XMLobject->dataElement('error', $Stacktrace, 'message' => $ErrorMessage); # Stderr

			# Alternatively, print a failure tag:
			#$XMLobject->emptyTag('failure', 'type' => 'failure');

			# Or, if the test was skipped, print this:
			#$XMLobject->emptyTag('skipped');
			
			# Otherwise, the test will be considered successful.

		$XMLobject->endTag('testcase');

	$XMLobject->endTag('testsuite');

$XMLobject->endTag('testsuites');
$XMLobject->end();
$XMLfile->close();