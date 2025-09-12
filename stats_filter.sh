#!/bin/bash

# Data filtering commands for transcriptomic/genomic data
# File format: INDEX_NAME SIZE_GB SAMPLE_COUNT

# 1. Get N largest indices by size
get_largest_by_size() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: get_largest_by_size <number> [file]"
        echo "       cat file | get_largest_by_size <number>"
        echo "Example: get_largest_by_size 10 data.txt"
        echo "Example: cat data.txt | get_largest_by_size 10"
        return 1
    fi
    local n="$1"
    local file="$2"
    
    if [ -z "$file" ]; then
        sort -k2 -nr | head -n "$n"
    else
        sort -k2 -nr "$file" | head -n "$n"
    fi
}

# 2. Get N largest indices by sample count
get_largest_by_samples() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: get_largest_by_samples <number> [file]"
        echo "       cat file | get_largest_by_samples <number>"
        echo "Example: get_largest_by_samples 10 data.txt"
        echo "Example: cat data.txt | get_largest_by_samples 10"
        return 1
    fi
    local n="$1"
    local file="$2"
    
    if [ -z "$file" ]; then
        sort -k3 -nr | head -n "$n"
    else
        sort -k3 -nr "$file" | head -n "$n"
    fi
}

# 3. Filter by exact category (e.g., METATRANSCRIPTOMIC_BCT)
filter_by_category() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: filter_by_category <category> [file]"
        echo "       cat file | filter_by_category <category>"
        echo "Example: filter_by_category METATRANSCRIPTOMIC_BCT data.txt"
        echo "Example: cat data.txt | filter_by_category METATRANSCRIPTOMIC_BCT"
        return 1
    fi
    local category="$1"
    local file="$2"
    
    if [ -z "$file" ]; then
        grep "^${category}_"
    else
        grep "^${category}_" "$file"
    fi
}

# 4. Filter by main category (e.g., METATRANSCRIPTOMIC)
filter_by_main_category() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: filter_by_main_category <main_category> [file]"
        echo "       cat file | filter_by_main_category <main_category>"
        echo "Example: filter_by_main_category METATRANSCRIPTOMIC data.txt"
        echo "Example: cat data.txt | filter_by_main_category METATRANSCRIPTOMIC"
        return 1
    fi
    local main_category="$1"
    local file="$2"
    
    if [ -z "$file" ]; then
        grep "^${main_category}_"
    else
        grep "^${main_category}_" "$file"
    fi
}

# 5. Filter by sub-category (e.g., BCT)
filter_by_sub_category() {
    if [ $# -eq 0 ] || [ $# -gt 2 ]; then
        echo "Usage: filter_by_sub_category <sub_category> [file]"
        echo "       cat file | filter_by_sub_category <sub_category>"
        echo "Example: filter_by_sub_category BCT data.txt"
        echo "Example: cat data.txt | filter_by_sub_category BCT"
        return 1
    fi
    local sub_category="$1"
    local file="$2"
    
    if [ -z "$file" ]; then
        grep "_${sub_category}_"
    else
        grep "_${sub_category}_" "$file"
    fi
}

# 6. Combined filters: Category + top N by size
filter_category_top_size() {
    if [ $# -eq 0 ] || [ $# -gt 3 ]; then
        echo "Usage: filter_category_top_size <category> <number> [file]"
        echo "       cat file | filter_category_top_size <category> <number>"
        echo "Example: filter_category_top_size METATRANSCRIPTOMIC_BCT 10 data.txt"
        echo "Example: cat data.txt | filter_category_top_size METATRANSCRIPTOMIC_BCT 10"
        return 1
    fi
    local category="$1"
    local n="$2"
    local file="$3"
    
    if [ -z "$file" ]; then
        grep "^${category}_" | sort -k2 -nr | head -n "$n"
    else
        grep "^${category}_" "$file" | sort -k2 -nr | head -n "$n"
    fi
}

# 7. Combined filters: Category + top N by sample count
filter_category_top_samples() {
    if [ $# -eq 0 ] || [ $# -gt 3 ]; then
        echo "Usage: filter_category_top_samples <category> <number> [file]"
        echo "       cat file | filter_category_top_samples <category> <number>"
        echo "Example: filter_category_top_samples METATRANSCRIPTOMIC_BCT 10 data.txt"
        echo "Example: cat data.txt | filter_category_top_samples METATRANSCRIPTOMIC_BCT 10"
        return 1
    fi
    local category="$1"
    local n="$2"
    local file="$3"
    
    if [ -z "$file" ]; then
        grep "^${category}_" | sort -k3 -nr | head -n "$n"
    else
        grep "^${category}_" "$file" | sort -k3 -nr | head -n "$n"
    fi
}

# 8. Combined filters: Main category + sub category
filter_main_and_sub() {
    if [ $# -eq 0 ] || [ $# -gt 3 ]; then
        echo "Usage: filter_main_and_sub <main_category> <sub_category> [file]"
        echo "       cat file | filter_main_and_sub <main_category> <sub_category>"
        echo "Example: filter_main_and_sub METATRANSCRIPTOMIC BCT data.txt"
        echo "Example: cat data.txt | filter_main_and_sub METATRANSCRIPTOMIC BCT"
        return 1
    fi
    local main_category="$1"
    local sub_category="$2"
    local file="$3"
    
    if [ -z "$file" ]; then
        grep "^${main_category}_.*_${sub_category}_"
    else
        grep "^${main_category}_.*_${sub_category}_" "$file"
    fi
}

# 9. Triple filter: Main + sub category + top N by size
filter_triple_size() {
    if [ $# -eq 0 ] || [ $# -gt 4 ]; then
        echo "Usage: filter_triple_size <main_category> <sub_category> <number> [file]"
        echo "       cat file | filter_triple_size <main_category> <sub_category> <number>"
        echo "Example: filter_triple_size TRANSCRIPTOMIC HUMAN 5 data.txt"
        echo "Example: cat data.txt | filter_triple_size TRANSCRIPTOMIC HUMAN 5"
        return 1
    fi
    local main_category="$1"
    local sub_category="$2"
    local n="$3"
    local file="$4"
    
    if [ -z "$file" ]; then
        grep "^${main_category}_.*_${sub_category}_" | sort -k2 -nr | head -n "$n"
    else
        grep "^${main_category}_.*_${sub_category}_" "$file" | sort -k2 -nr | head -n "$n"
    fi
}

# 10. Triple filter: Main + sub category + top N by sample count
filter_triple_samples() {
    if [ $# -eq 0 ] || [ $# -gt 4 ]; then
        echo "Usage: filter_triple_samples <main_category> <sub_category> <number> [file]"
        echo "       cat file | filter_triple_samples <main_category> <sub_category> <number>"
        echo "Example: filter_triple_samples TRANSCRIPTOMIC HUMAN 5 data.txt"
        echo "Example: cat data.txt | filter_triple_samples TRANSCRIPTOMIC HUMAN 5"
        return 1
    fi
    local main_category="$1"
    local sub_category="$2"
    local n="$3"
    local file="$4"
    
    if [ -z "$file" ]; then
        grep "^${main_category}_.*_${sub_category}_" | sort -k3 -nr | head -n "$n"
    else
        grep "^${main_category}_.*_${sub_category}_" "$file" | sort -k3 -nr | head -n "$n"
    fi
}

# 11. Get summary statistics for filtered data
get_stats() {
    if [ $# -gt 1 ]; then
        echo "Usage: get_stats [file]"
        echo "       cat file | get_stats"
        echo "Example: get_stats data.txt"
        echo "Example: cat data.txt | get_stats"
        return 1
    fi
    local file="$1"
    
    if [ -z "$file" ]; then
        local data=$(cat)
    else
        local data=$(cat "$file")
    fi
    
    echo "=== STATISTICS ==="
    echo "Total entries: $(echo "$data" | wc -l)"
    echo "Total size (GB): $(echo "$data" | awk '{sum+=$2} END {printf "%.5f\n", sum}')"
    echo "Total samples: $(echo "$data" | awk '{sum+=$3} END {print sum}')"
    echo "Size range: $(echo "$data" | awk 'NR==1{min=max=$2} {if($2<min) min=$2; if($2>max) max=$2} END {printf "%.5f - %.5f\n", min, max}')"
    echo "Sample range: $(echo "$data" | awk 'NR==1{min=max=$3} {if($3<min) min=$3; if($3>max) max=$3} END {print min " - " max}')"
}