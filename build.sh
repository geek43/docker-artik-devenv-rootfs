#!/bin/sh
set -ev

pids=""

#./build_fedora.sh f710 &
#pids+=" $!"

#./build_fedora.sh f530 &
#pids+=" $!"

#./build_fedora.sh f520 &
#pids+=" $!"

#./build_ubuntu.sh u710 &
#pids+=" $!"

#./build_ubuntu.sh u530 &
#pids+=" $!"

./build_ubuntu.sh u710cross &
pids+=" $!"

./build_ubuntu.sh u530cross &
pids+=" $!"

# Wait for all processes to finish.
for p in $pids; do
	if wait $p; then
		echo "Process $p success"
	else
		echo "Process $p fail"
		exit 1
	fi
done

