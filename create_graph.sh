#!/bin/bash

help() {
    echo "USAGE: create_graph -m <MODEL_NAME> -c <CONFIG_FILE> -t <TRAIN_CHECKPOINT>"
	  echo ""  
		exit 0
}
while getopts "c:m:t:h" opt
do
    case $opt in
        m) model=$OPTARG
          ;;
				c) config_file=$OPTARG
					;;
				t) train_checkpoint=$OPTARG
					;;
        h) help ;;
        ?) help ;;
    esac
done
 
if [ -z $model ]; then
	echo "Miss <MODEL_NAME>"
	help
fi
if [ -z $config_file ]; then
	echo "Miss <CONFIG_FILE>"
	help
fi
if [ -z $train_checkpoint ]; then
	echo "MISS <TRAIN_CHECKPOINT>"
	help
fi



echo $model

PWD=$(pwd)

export PYTHONPATH=${PWD}/models/research/:${PWD}/models/research/slim:${PWD}/models/research/object_detection:$PYTHONPATH

echo $PYTHONPATH
python models/research/object_detection/export_inference_graph.py --pipeline_config_path ${config_file} --train_dir /home/jinu/Desktop/traffic-sign-detection/${model}/train/ --input-type image_tensor --trained_checkpoint_prefix ${train_checkpoint} --output_directory ${model}/inference_graph

