#!/usr/bin/env python

# script: From Adrian
from collections import defaultdict

import numpy as np
import pandas as pd
from tqdm import tqdm
import argparse

## python decision_plotting_prepare.py --input read_until_FAP76673_e0481cad.csv --output first_steps.csv --chunksize 50

parser = argparse.ArgumentParser(description='read until parser for decision_plotting_prepare')
parser.add_argument(
    '--input', required=True, help='choose inputfile: read_untilFAP*.csv')
parser.add_argument(
    '--output', required=True, help='Where to save the splitted csv for plotting')
# parser.add_argument(
#     '--chunk_size', required=True, help='size of basepair_chunks/segments to plot, eg 50 ')
args = parser.parse_args()


def get_bin(i, breaks):
    for b in breaks:
        if i > b:
            continue
        else:
            return b
    return breaks[-1]


# Params
fp = args.input
df = pd.read_csv(fp)

# max length of longest read for 
sequence_length = df["sequence_length"]
sequence_length_max_lenght = sequence_length.max()
# breaks = [1000, 2000, 3000, 4000, 5000]
breaks = list(np.arange(0, sequence_length_max_lenght, 100)[1:])


# Go
d = {}
for _, i in tqdm(df.iterrows()):
    # We assume the df is sorted ie subsequent rows of the same read increase
    # in read len. If this is not the case, sort the df on read name and then
    # length first.
    d[i['read_id']] = [i['sequence_length'], i['decision']]


# Bookkeeping
no_decision = {b: 0 for b in breaks}
unblock = {b: 0 for b in breaks}
stop_receiving = {b: 0 for b in breaks}

for k, v in d.items():
    l, decision = v
    bn = get_bin(l, breaks)
    
    # Count +1 all the bins that came before the last one for each read;
    # by definition they are no_decision
    for i in [b for b in breaks if b < bn]:
        no_decision[i] += 1
    # If we want to broadcast the decision for all breaks after bn:
    for i in [b for b in breaks if b > bn]:
        if decision == 'no_decision':
            no_decision[i] += 1
        elif decision == 'stop_receiving':
            stop_receiving[i] += 1
        else:  # unblock
            unblock[i] += 1
    if decision == 'no_decision':
        no_decision[bn] += 1
    elif decision == 'stop_receiving':
        stop_receiving[bn] += 1
    else:  # unblock
        unblock[bn] += 1

with open(args.output, 'w+') as out:
    out.write('bin,cnt,state\n')  # header
    for k, v in unblock.items():
        out.write(f'{k},{v},unblock\n')
    for k, v in stop_receiving.items():
        out.write(f'{k},{v},stop_receiving\n')    
    for k, v in no_decision.items():
        out.write(f'{k},{v},no_decision\n')