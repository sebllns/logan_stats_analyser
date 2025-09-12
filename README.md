# logan_stats_analyser

## Usage

Input format :
1 index per line with the following format  
`INDEX SIZE_GB SAMPLE_COUNT`

Example:

```
GENOMIC_BCT_10_null 0.00668 2424
GENOMIC_BCT_11_null 0.00859 3401
GENOMIC_BCT_12_null 0.02273 5386
GENOMIC_BCT_13_null 0.05540 9273
GENOMIC_BCT_14_null 0.20384 17580
GENOMIC_BCT_15_null 0.75564 32832
GENOMIC_BCT_16_null 2.81000 61279
GENOMIC_BCT_17_null 11.48000 127983
GENOMIC_BCT_18_null 36.34000 204825
GENOMIC_BCT_19_null 85.45000 242142
```

### HTML Visualizer

Open the HTML file `stats_visualizer.html`  
Load your index list (`browse` button)

For instance, you can filter by category, or manually add an index to the cart to get aggregated stats and export the cart to your custom list.

### Bash Filter

First source the script

```bash
. stats_filter.h
```

Then use filters

Examples 


Get the 10 largest indexes
```bash
get_largest_by_size 10 list_size_samples.txt
```
Output:
```bash
GENOMIC_MICE_30 14548.48000 20163
GENOMIC_VRT_29 13030.40000 36126
GENOMIC_HUMAN_28 12561.92000 69655
GENOMIC_PRI_31 10526.72000 7291
GENOMIC_MICE_29 10511.36000 29139
GENOMIC_MAM_30 9118.72000 12640
GENOMIC_MICE_27 8880.65000 98484
GENOMIC_MICE_28 7925.76000 43940
GENOMIC_VRT_31 7779.84000 5388
GENOMIC_MICE_32 5977.60000 2069
```

You can pipe filters.

Example: Get the the 5 largest indexes in TRANSCRIPTOMIC_HUMAN category

```bash
 filter_by_category TRANSCRIPTOMIC_HUMAN list_size_samples.txt | get_largest_by_size 5 
```

Output

```bash
TRANSCRIPTOMIC_HUMAN_30_0 5908.48000 8192
TRANSCRIPTOMIC_HUMAN_29_2 5908.48000 16384
TRANSCRIPTOMIC_HUMAN_29_1 5908.48000 16384
TRANSCRIPTOMIC_HUMAN_29_0 5908.48000 16384
TRANSCRIPTOMIC_HUMAN_28_2 5908.48000 32768
```
Aggregated stats

Example: 

```bash
 filter_by_category TRANSCRIPTOMIC_HUMAN list_size_samples.txt | get_largest_by_size 5 | get_stats
```

Output

```bash
 === STATISTICS ===
Total entries: 5
Total size (GB): 29542.40000
Total samples: 90112
Size range: 5908.48000 - 5908.48000
Sample range: 8192 - 32768
```
