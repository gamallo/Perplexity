#!/bin/bash

echo "Generating the models"
sh train.sh  gz
sh train.sh  pt
sh train.sh  es

echo "Making all possible tests"
sh test.sh gz gz
sh test.sh gz pt
sh test.sh gz es
sh test.sh pt pt
sh test.sh pt gz
sh test.sh pt es
sh test.sh es es
sh test.sh es pt
sh test.sh es gz 
