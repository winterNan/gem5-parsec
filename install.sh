source env.sh
parsecmgmt -a build -p libtool
parsecmgmt -a build -p hooks
parsecmgmt -a build -p blackscholes -c gcc-hooks
parsecmgmt -a build -p bodytrack -c gcc-hooks
parsecmgmt -a build -p canneal -c gcc-hooks
parsecmgmt -a build -p dedup -c gcc-hooks
parsecmgmt -a build -p facesim -c gcc-hooks
parsecmgmt -a build -p ferret -c gcc-hooks
parsecmgmt -a build -p fluidanimate -c gcc-hooks
parsecmgmt -a build -p freqmine -c gcc-hooks
parsecmgmt -a build -p streamcluster -c gcc-hooks
parsecmgmt -a build -p swaptions -c gcc-hooks
parsecmgmt -a build -p vips -c gcc-hooks
parsecmgmt -a build -p x264 -c gcc-hooks
echo "your_root_pwd" | sudo -S chown yuan -R /usr/local/
echo "your_root_pwd" | sudo -S chgrp yuan -R /usr/local/
parsecmgmt -a build -p raytrace -c gcc-hooks
cp -r /usr/local/bin/ /home/yuan/Benchmarks/parsec/parsec-3.0/pkgs/tools/cmake/inst/amd64-linux.gcc-hooks/
parsecmgmt -a build -p raytrace -c gcc-hooks
cp -r /usr/local/bin/ /home/yuan/Benchmarks/parsec/parsec-3.0/pkgs/apps/raytrace/inst/amd64-linux.gcc-hooks/
echo "your_root_pwd" | sudo -S chown root -R /usr/local/
echo "your_root_pwd" | sudo -S chgrp root -R /usr/local/
./get-inputs
