#!/usr/bin/env bash
#color

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}

function build_docker(){
	docker build -t odinms_mysql odinms_mysql
	docker build -t odinms odinms

	ODINMS_MYSQL_CONTAINER_ID=`docker run -d -p 3306:3306 odinms_mysql`
	ODINMS_MYSQL_CONTAINER_IP_ADDRESS=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $ODINMS_MYSQL_CONTAINER_ID`
}

#clear all docker
function clr(){
	echo "cleaning...\n"
	docker stop $(docker ps -a -q) 
	docker rm $(docker ps -a -q)
	docker ps -a
}

function envtst(){
	build_docker
	#docker run -it --rm -e ODINMS_MYSQL_CONTAINER_IP_ADDRESS=$ODINMS_MYSQL_CONTAINER_IP_ADDRESS -p 7575:7575 -p 7576:7576 -p 7577:7577 -p 7578:7578 -p 8484:8484 odinms bash
	docker run -it --rm -e ODINMS_MYSQL_CONTAINER_IP_ADDRESS=$ODINMS_MYSQL_CONTAINER_IP_ADDRESS -p 7575:7575 -p 7576:7576 -p 7577:7577 -p 7578:7578 -p 8484:8484 odinms bash
	docker rm -f $ODINMS_MYSQL_CONTAINER_ID
}

function programtst(){
	build_docker
	docker run -it -e ODINMS_MYSQL_CONTAINER_IP_ADDRESS=$ODINMS_MYSQL_CONTAINER_IP_ADDRESS -p 7575:7575 -p 7576:7576 -p 7577:7577 -p 7578:7578 -p 8484:8484 odinms bash
}

#Main menu
function start_menu(){
    clear
    red "thepack_82_docker"
    green " FROM: https://github.com/thepack82/thepack_82_docker "
    green " HELP: http://forum.ragezone.com/f427/v62-docker-1150928/ "
    green " USE:  1-environment test,With this option, you can quickly complete the test and clean up your environment."
    green " USE:  2-Program Test,You can learn and study this classic game and improve your skills in this option."
    green " USE:  3-clean all docker images. Be careful"
    yellow " =================================================="
    green " 1. Environment test 环境测试"
    green " 2. Program Test 程序测试"
    green " 3. Clean 清理程序"
    yellow " =================================================="
    green " 0. Quit退出脚本"

    green " TOS:Source code source from the web.For study and research use only, please do not make any commercial use, delete as soon as possible after use."
    green " 免责声明：源代码来源自网络，仅供学习研究使用，请勿做任何商业用途，使用后请尽快删除。"
    echo
    read -p "Enter a number:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           envtst
        ;;
        2 )
           programtst
        ;;
        3 )
           clr
        ;;
	0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac	   
}

start_menu

