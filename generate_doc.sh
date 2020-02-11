#!/bin/sh

echo 'Setting up the script...'
# Exit with nonzero exit code if anything fails
set -e

# Remove everything currently in the gh-pages branch.
rm -rf cubrid
rm -rf docs

# Need to create a .nojekyll file to allow filenames starting with an underscore
# to be seen on the gh-pages site. Therefore creating an empty .nojekyll file.
# Presumably this is only needed when the SHORT_NAMES option in Doxygen is set
# to NO, which it is by default. So creating the file just in case.
echo "" > .nojekyll

# git clone --recurse-submodules https://github.com/CUBRID/cubrid.git cubrid
git clone https://github.com/CUBRID/cubrid.git cubrid
rsync -a $TRAVIS_BUILD_DIR/cubrid/ $TRAVIS_BUILD_DIR/

echo 'Generating Doxygen code documentation...'
# Redirect both stderr and stdout to the log file AND the console.
doxygen Doxyfile 2>&1 | tee doxygen.log