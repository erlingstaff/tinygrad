#!/bin/bash

export PYTHONPATH="."
export MODEL="resnet"
export SUBMISSION_PLATFORM="tinybox_red"
export DEFAULT_FLOAT="HALF" GPUS=6 BS=1536 EVAL_BS=48 LR=7

export SPLIT_REDUCEOP=1 LAZYCACHE=0 RESET_STEP=0

export TRAIN_BEAM=4 IGNORE_JIT_FIRST_BEAM=1 BEAM_UOPS_MAX=1500 BEAM_UPCAST_MAX=128 BEAM_LOCAL_MAX=1024 BEAM_MIN_PROGRESS=25

# pip install -e ".[mlperf]"
export LOGMLPERF=1

export SEED=$RANDOM
DATETIME=$(date "+%m%d%H%M")
LOGFILE="resnet_red_${DATETIME}_${SEED}.log"

# init
BENCHMARK=10 INITMLPERF=1 python3 examples/mlperf/model_train.py | tee $LOGFILE

# run
WANDB=1 PARALLEL=0 RUNMLPERF=1 python3 examples/mlperf/model_train.py | tee -a $LOGFILE