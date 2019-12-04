#!/bin/bash

help() {
    echo "USAGE: train.sh -m <MODEL_NAME> -c <CONFIG_FILE>"
    echo ""  
    exit 0
}
while getopts "c:m:h" opt
do
    case $opt in
        m) model=$OPTARG
					;;
				c) config_file=$OPTARG
          ;;
        h) help ;;
        ?) help ;;
    esac
done

if [ -z $model ]; then
  echo "Miss <MODEL_NAME>"
  help
elif [ -z $config_file ]; then
	echo "Miss <CONFIG_FILE>"
	help
fi




PWD=$(pwd)

export PYTHONPATH=${PWD}/models/research/:${PWD}/models/research/slim:${PWD}/models/research/object_detection:$PYTHONPATH

echo $PYTHONPATH
python models/research/object_detection/legacy/train.py --pipeline_config_path $config_file --train_dir ${model}/train

