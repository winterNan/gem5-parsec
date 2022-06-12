#!/bin/bash
#
# author: Yuan Yao
#         yuan.yao@it.uu.se
#
# Research group UART, Uppsala University
#
# The script automatically uses KVM to fast forward
# a benchmark to the begining of ROI, then checkpoints
# the execution. It can also resume later from the checkpoint 
# using the resumt_ckpt command.
#
# Supported benchmarks: PARSEC-3.0

PARSEC_APP_DIR="."

PROGRAM=$1
PROGRAM_SET=("blackscholes" "bodytrack" "facesim" "ferret" "fluidanimate" "freqmine" "raytrace" "swaptions" "vips" "x264")
KERNEL_SET=("canneal" "dedup" "streamcluster")

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

func_check_program_name(){
        if [[ " ${PROGRAM_SET[@]} " =~ " $PROGRAM " ]]; then
                PARSEC_APP_DIR="$PARSEC_INSTALL_DIR/pkgs/apps/$PROGRAM/inst/amd64-linux.gcc-hooks/bin/$PROGRAM"
                PKGPARSECDIR=${PARSEC_INSTALL_DIR}/pkgs/apps/$PROGRAM/parsec

        elif [[ " ${KERNEL_SET[@]} " =~ " $PROGRAM " ]]; then
                PARSEC_APP_DIR="$PARSEC_INSTALL_DIR/pkgs/kernels/$PROGRAM/inst/amd64-linux.gcc-hooks/bin/$PROGRAM"
                PKGPARSECDIR=${PARSEC_INSTALL_DIR}/pkgs/kernels/$PROGRAM/parsec

        else
                echo -e "Program name ${RED}wrong${NC}."
                echo -e "Valid names: 
                        PARSEC-3.0 apps: ${PROGRAM_SET[@]}, 
                        PARSEC-3.0 kernels: ${KERNEL_SET[@]}."
                echo -e "Now exit..."
                exit -1;
        fi
}

if [[ " $1 " =~ " all " ]]; then

	for i in "${PROGRAM_SET[@]}"
	do
		PARSEC_APP_DIR="$PARSEC_INSTALL_DIR/pkgs/apps/$i/inst/amd64-linux.gcc-hooks/bin/$i"
		info=`file $PARSEC_APP_DIR`
		if [[ $info == *"statically"* ]]; then
			echo -e ${GREEN}$info
		elif [[ $info == *"dynamically"* ]]; then
			echo -e ${RED}$info
		else
			echo -e "${RED}Error${NC} while reading file type of $PARSEC_APP_DIR"
		fi
	done

	for i in "${KERNEL_SET[@]}"
	do
		PARSEC_APP_DIR="$PARSEC_INSTALL_DIR/pkgs/kernels/$i/inst/amd64-linux.gcc-hooks/bin/$i"
		info=`file $PARSEC_APP_DIR`
		if [[ $info == *"statically"* ]]; then
			echo -e ${GREEN}$info
		elif [[ $info == *"dynamically"* ]]; then
			echo -e ${RED}$info
		else
			echo -e "${RED}Error${NC} while reading file type of $PARSEC_APP_DIR"
		fi
	done

	return
else 
	func_check_program_name;

	info=`file $PARSEC_APP_DIR`
	if [[ $info == *"statically"* ]]; then
		echo -e ${GREEN}$info
	elif [[ $info == *"dynamically"* ]]; then
		echo -e ${RED}$info
	else
		echo -e "${RED}Error${NC} while reading file type of $PARSEC_APP_DIR"
	fi
fi
 

