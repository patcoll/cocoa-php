<?php
$descriptorspec = array(
   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
   2 => array("file", "/tmp/Web-error-output.txt", "a") // stderr is a file to write to
);

$script = "/Users/patcollins/bin/Web";
$pipes = array();
$cwd = '/tmp';
$env = array('WEB_ENV' => json_encode($_SERVER));
// $env = $_SERVER;
// var_dump($env);

$process = proc_open($script, $descriptorspec, $pipes, $cwd, $env);

// http://php.net/manual/en/function.proc-open.php
if (is_resource($process)) {
    // $pipes now looks like this:
    // 0 => writeable handle connected to child stdin
    // 1 => readable handle connected to child stdout
    // Any error output will be appended to /tmp/error-output.txt

    echo stream_get_contents($pipes[1]);
    fclose($pipes[1]);

    // It is important that you close any pipes before calling
    // proc_close in order to avoid a deadlock
    $return_value = proc_close($process);

    // echo "$return_value\n";
}