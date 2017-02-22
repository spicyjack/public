#!/usr/bin/env php
<?php

   $regex = "/^\d+$|^(?:[\d+,])+(?:\d+)$/";
   $stdin = rtrim(fgets(STDIN));

   // check that $proposal_id is a valid proposal ID
   if ( preg_match($regex, $stdin) === 1 ) {
      echo "Input '$stdin' matches regex '$regex'\n";
   } else {
      echo "Input '$stdin' does not match regex '$regex'\n";
   }
?>
