Perl-2-Jenkins
==============

####A template for creating a JUnit-formatted test results file with Perl that can be parsed by Jenkins

[Jenkins](http://jenkins-ci.org/) natively parses Java [JUnit](http://junit.org/) software test results that are displayed in regression tables and trend charts.  A plugin called [xUnit](https://wiki.jenkins-ci.org/display/JENKINS/xUnit+Plugin) is available for use with JUnit-like frameworks for other languages.  However, it may be inconvenient to move to one of these frameworks when it would involve rewriting a large amount of test code.

**Perl-2-Jenkins** is a template for saving a JUnit-formatted XML results file that Jenkins understands using only simple Perl varialbes.  This structure can be easily looped and embedded into pre-existing software test aggregation code, and **no** additional software test frameworks are required.

Perl modules required:
* [XML::Writer](http://search.cpan.org/perldoc?XML%3A%3AWriter)
* IO::File (standard)

Install [CPAN](http://www.cpan.org/modules/INSTALL.html) on your system to easily install new modules.

This code has been tested with the native JUnit capability of Jenkins.  Simply save the XML file to a job's workspace, and add a **Publish JUnit test result report** post-build step to the job's configuration.
