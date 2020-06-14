#! /bin/bash

val=`cat .redshift_val`
val=$((val+500))
redshift -P -O $val

echo $val > .redshift_val
