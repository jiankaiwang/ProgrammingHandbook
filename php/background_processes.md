# Background processes

<script type="text/javascript" src="../js/general.js"></script>

###Background
---

* In many cases, it might meet some needs to execute programs in the background, for example, continuous executions, high time complexity calculations, etc. But, PHP is the kinds of preprocesser for the webpage, how to deal with the problem? The following is the example showing how to implement codes with front and background codes in PHP script.

###background code
---

* The example used sleep to simulate increasing time for executing the program. After, use a simple print() to output the result. The file name is "background_process.php".

```php
<?php
# use sleep to simulate the code executed
sleep(60);

# use the print to simulate the output of executing
print("Execution is completed.\n");
?>
```

###front code
---

* The simple code implemented how to mirror the background process with auto meta redirect in a fixed time peroid. The file name is "front_check.php".

```php
<?php
# the beginning message
echo 'Start to mirror the background process';

# check the progress of background process
# use isRunning() to mirror the current status
function isRunning($pid) {
        try {   
                # ps is to get the current process
                $result = shell_exec(sprintf("ps %d",$pid));
                if(count(preg_split("/\n/",$result)) > 2) {
                        return true;
                }
        } catch (Exception $e) {
                echo '[Status] exception occured.';
        }
        return false;
}

# use GET to control not the same background process called
if($_GET["call"] == 1) {
        $getStatus = isRunning($_GET["pid"]);
        switch($getStatus) {
        case true:
                echo 'Current status: Running.';
                echo '<meta http-equiv="refresh" content="1;url=/php/front_check.php?pid='.$_GET["pid"].'&call=1"></meta>';
                break;
        case false:
                echo 'Current status: Complete.';
                break;
        }
} else {
        $cmd = "php /var/www/html/php/background_process.php";

        # path of output file must be sure with full access control
        # step.1: change SELinux policy
        #      $ sudo semanage fcontext -a -t httpd_sys_rw_content_t 'PATH_FOR_WRITING'
        # step.2: make the path restore SELinux policy
        #      $ sudo restorecon -v 'PATH_FOR_WRITING'
        # step.3: restart the whole server
        #      $ sudo systemctl restart httpd
        $outputfile = "/var/www/html/php/output.txt";

        # start to call command to run in the backgound
        # 2>&1: redirect stderr to stdout
        # & before echo means execute in the background
	# exec — Execute an external program
	# system — Execute an external program and display the output
	# shell_exec — Execute command via shell and return the complete output as a string
        $pidfile = shell_exec(sprintf("%s > %s 2>&1 & echo $!",$cmd,$outputfile));
        echo '<meta http-equiv="refresh" content="1;url=/php/front_check.php?pid='.$pidfile.'&call=1"></meta>';
}
?>
```

###How to use them
---

* Use the urls to quickly implement them.

```php
# front page
http://xxx.xxx.xxx/php/front_check.php&call=0
```


