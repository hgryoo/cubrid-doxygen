git clone --recursive-submodules https://github.com/CUBRID/cubrid.git cubrid
rsync -a $TRAVIS_BUILD_DIR/cubrid/ $TRAVIS_BUILD_DIR/
rm -rf $TRAVIS_BUILD_DIR/cubrid
doxygen Doxyfile
