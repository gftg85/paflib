#!/bin/bash

ENAME=$0

usage()
{
cat << EOF
Usage: $ENAME OPTION
  -x Clean git repository before preparing release
EOF
}


while getopts "x" opt; do
	case "$opt" in
	x )
		git clean -ffdx
		;;
	? )
		usage
		exit 1
		;;
	esac
done

logfile=${PWD}/release.$(date +%y-%m-%d-%T).log
echo "Logging to ${logfile}"

# TODO: Handle tagging?

# Ensure these all have a similar and sane timestamp to
# prevent autotools from trying to rebuild portions wrongly
touch configure.ac aclocal.m4 configure Makefile.am Makefile.in

if [ ! -e ./configure ]; then
	echo "Configure missing. Did you bootstrap?"
fi

config_opts=""
if ./configure --help | grep -- --enable-maintainer-mode > /dev/null; then
	config_opts+=" --enable-maintainer-mode";
fi

echo "Running configure with options '${config_opts}'"
if ! ./configure $config_opts >> ${logfile} 2>&1; then
	echo "Configuration failed. Aborting"
	exit 1
fi

if [ ! -e Makefile ]; then
	echo "Makefile missing. Aborting"
	exit 1
fi

echo "Running make distcheck"
make distcheck >> ${logfile} 2>&1

if [ $? != 0 ]; then
	echo "make distcheck failed. Aborting"
	exit 1
fi

# Extract out the name of the tarball from the log.
# There is probably a saner method to do this.

tarballs=$(awk '
/^=+$/ && doprint == 1                 { exit 0 }
doprint == 1                           { print $0 }
$0 ~ /archives ready for distribution/ { doprint = 1 }
' ${logfile})

if [ "x${tarballs}" == "x" ]; then
	echo "Failed to build and verify tarballs"
	exit 1
fi

echo "Found tarballs: ${tarballs}"

# Generate some popular checksums for the tarball
for tarball in ${tarballs}; do
	for sum in sha256 md5; do
		echo "Generating ${tarball}.${sum}"
		${sum}sum ${tarball} > ${tarball}.${sum}
	done
done

# TODO: Support signing these releases

exit 0
