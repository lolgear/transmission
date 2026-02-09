function preparing_crc32c() {
	echo "Preparing crc32c"

	if [ -d "crc32c/include/crc32c" ]; then
		cp ./macosx-crc32c-config.h ./crc32c/include/crc32c/crc32c_config.h
	else
		echo "crc32c does not exist."
	fi
}

function preparing_libevent() {
	echo "Preparing libevent"

	if [ -d "libevent/include/event2" ]; then
		cp ./macosx-libevent-evconfig-private.h ./libevent/include/evconfig-private.h
		cp ./macosx-libevent-event-config.h ./libevent/include/event2/event-config.h
	else
	 	echo "libevent does not exist."
	fi
}

function preparing_natpmp() {
	echo "Preparing libnatpmp"

	if [ -d "libnatpmp" ]; then
		mkdir ./libnatpmp/include
		cp ./libnatpmp/getgateway.h ./libnatpmp/include
		cp ./libnatpmp/natpmp.h ./libnatpmp/include
	else
		echo "libnatpmp does not exist."
	fi
}

function preparing_psl() {
	echo "Preparing libpsl"

	if [ -d "libpsl/include" ]; then
		sed 's|@LIBPSL_[A-Z_]*@|0|' < ./libpsl/include/libpsl.h.in > ./libpsl/include/libpsl.h

		# Generate files to be included
		PYTHON=$( command -v python3 ) || PYTHON=$( command -v python3.7 ) || PYTHON=$( command -v python2 )
		"${PYTHON}" "./libpsl/src/psl-make-dafsa" --output-format=cxx+ "./libpsl/list/public_suffix_list.dat" "./libpsl/include/suffixes_dafsa.h"

	else
		echo "libpsl does not exist."
	fi
}

function preparing_miniupnp() {
	echo "Preparing miniupnp"

	if [ -d "miniupnp/miniupnpc" ]; then
		cd ./miniupnp/miniupnpc
		sh updateminiupnpcstrings.sh
		cd -
	else
		echo "miniupnp does not exist."
	fi
}

cd "$(dirname -- "$0")"

preparing_crc32c
preparing_libevent
preparing_natpmp
preparing_psl
preparing_miniupnp
