<?php

require "shell.class.php";

$shell = new shell;

$shell->ls("./heyarabo/", function($name, $file) {
    if(preg_match("/framework\/(controller|model)/", $file, $m)) {
        $content = file_get_contents($file);
        $package = str_replace("/", ".", $m[0]);
        //package comment
        $package_comment= <<<PACKAGE_COMMENT
/**
 * {$name}
 *
 * myFramework : Origin Framework by Chen Han https://github.com/gpgkd906/framework
 *
 * Copyright 2014 Chen Han
 *
 * Licensed under The MIT License
 *
 * @copyright Copyright 2014 Chen Han
 * @link
 * @since
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 */
PACKAGE_COMMENT;
        $content = str_replace("<?php", "<?php" . PHP_EOL . $package_comment, $content);
        //class
        $class_comment = <<<CLASS_COMMENT
/**
 * {class}
 *
 *####
 *  
 *
 *
 * @author 2014 Chen Han 
 * @package {$package}
 * @link 
 */
CLASS_COMMENT;
        //$content = str_replace("class ", $class_comment . PHP_EOL . "class ", $content);
        $content = preg_replace_callback("/class\s(\S*)/", function($matchs) use ($class_comment){
                $class = $matchs[1];
                $class_comment = str_replace("{class}", $class, $class_comment);
                return $class_comment . PHP_EOL . $matchs[0];
            }, $content);
        //var
        $vars_comment = <<<VARS_COMMENT
        /**
	     * @api
	     * @var boolean
	     * @link
	     */
VARS_COMMENT;
        $content = preg_replace("/.*?(public|protected|private)\s(static\s)?\\\$/", $vars_comment . PHP_EOL . '$0', $content);
        //method
        $method_comment = <<<METHOD_COMMENT
        /**
         * @api
{params}
         * @return
         * @link
         */
METHOD_COMMENT;
        $content = preg_replace_callback("/.*?(?:public|protected|private)\s(?:static\s)?function.*?\((.*?)\)/", function($matchs) use ($method_comment){
                $params = isset($matchs[1]) ? explode(",", str_replace(" = ", " ", $matchs[1])):array();
                $ps = array();
                foreach($params as $p) {
                    $ps[] = "         * @param  " . $p;
                }
                $method_comment = str_replace("{params}", join(PHP_EOL, $ps), $method_comment);
                return $method_comment . PHP_EOL . $matchs[0];
            }, $content);
        file_put_contents($file, $content);
    }
});


