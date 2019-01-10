#!/usr/bin/env python3

set -ex

if [ "$#" -lt 1 ]; then
    echo "Requires a name parameter"
    exit 1
fi

NAME=$1; shift

cd "${ITHEMAL_HOME}/learning/pytorch"

experiments/download_data.sh

NAMEDATE="${NAME}_$(date '+%m-%d-%y_%H:%M:%S')"
SAVEFILE="saved/${NAMEDATE}.mdl"
LOSS_REPORT_FILE="loss_reports/${NAMEDATE}.log"

mkdir -p saved/checkpoints

python ithemal/run_ithemal.py --embmode none --embedfile inputs/embeddings/code_delim.emb --savedatafile saved/time_skylake_1217.data --arch 2 --epochs 5 --savefile "${SAVEFILE}" --loss-report-file "${LOSS_REPORT_FILE}" --checkpoint-dir saved/checkpoints "${@}"

"${ITHEMAL_HOME}/aws/ping_slack.py" "Experiment ${NAME} complete"
