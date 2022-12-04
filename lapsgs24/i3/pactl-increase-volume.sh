VOLUME=$2
for SINK in $(pacmd list-sinks | grep 'index:' | cut -b12-); do
	pacmd set-sink-volume $SINK $VOLUME
done
