#! /bin/sh

for i in `seq 0 10`; do
	pulseaudio -k;
	sleep 1;
done

pulseaudio -D

