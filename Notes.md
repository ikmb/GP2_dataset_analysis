# Dataset description
The dataset consists from four tables with 16S counts.  I subseted this table , so I would have GP2 levels for all samples. Two tables belongs to healthy individuals - BSPSPC (we renamed it to HC lately). One of them is stool table, another is serum table. BSPSPC with serum table - 50 samples,
BSPSPC with stool table - 50 samples.
Two other tables belong to PSC patient, PSC with serum table - 131 sample, PSC with stool table - 527 sample
We have also metadata with GP2 protein level, which represents following indicators: GP2_Iso1_IgG	GP2_Iso1_IgA	GP2_Iso4_IgG	GP2_Iso4_IgA	PR3. Iso in the name means isoform, and I used U/ml units for the analysis. 
See 01_2020-023_explore_data.ipynb

# ASV analysis
I normalized the count tables based on their reads distribution plots. The normalization factors were determined as follows:
BSPSPC serum samples were normalized by a sample depth of 5000.
BSPSPC stool samples were normalized by a sample depth of 10000.
PSC serum samples were normalized by a sample depth of 2500.
PSC stool samples were normalized by a sample depth of 10000.
Since the data were represenred by two tables, I merged them. To achieve this, I renamed the ASVs according to the intersected sequences of primers. After aligning the ASVs in row names, I merged the tables using the QIIME merge function.
For ASV filtration, I applied the following criteria: - minimum count 4 in 10% of samples and 5% based on inter-quantile rang. 
So, after rarefecation and filtration, I had 507 PSC stool samples and 46 BSPSPC samples, and 191 ASVs.
Alpha-diverstity was performed separately for stool and serum samples. 
BSPCPS had significantly higher diversity then PSC in stool samples.
In terms of Beta-diversity, the variability was higher for PSC samples.
See 02_2020-023_asv_analysis.ipynb

# Average taxonomic abundances
The same procedures were applied to the genus tables, including normalization, merging, and filtration. The with qiime tool I calculated relative abundances and created a bar plot illustrating the abundances. Taxa with a frequency of less than 1% were aggregated into a single category.
See 03_2020-023_avrg_abundances.ipynb

# Differential abundances analysis
Differential abundances analysis was conducted using the ANCOMBC tool. BSPSPC was a reference group. I compared following pairs: PSC seren vs PSC stool, BSPSPC seren vs BSPSPC stool, PSC stool vs BSPSPC stool, PSC seren vs BSPSPC seren. This allowed us to examine differences within materials and within diseases.
The primary focus of further analysis was the comparison between PSC stool and BSPSPC stool samples.
The final results I visualized with barplots, where on y -axis it was LogFC and on x-axis it was the name of taxa, the bars were colored with blue, if the logFC < 0 and with red if logFC>0
Following taxa were selected for further analysis
F__Porphyromonadaceae	
F__Ruminococcaceae	
G__Alistipes	
G__Escherichia.Shigella	
G__Flavonifractor	
G__Oxalobacter	
G__Phascolarctobacterium	
G__Prevotella	
G__Sutterella	
O__Clostridiales
P__Firmicutes
See 04_diff_abundances.r, 05_diff_abundances.r, 06_diff_abundances.r, 07_diff_abundances.r

# GP2 analysis
In the GP2 analysis, I began by comparing GP2 indicators between BSPSPC and PSC groups using the Wilcoxon test. The results showed that GP2_Iso1_IgG, GP2_Iso1_IgA, and PR3 were significantly higher in the PSC group, whereas GP2_Iso4_IgG was significantly higher in the BSPSPC group.
Next, I explored the association between microbiota and each GP2 marker. After dropping samples with 0 GP2 values, I performed mixed linear regression, considering the two groups - PSC and BSPSPC. However, the overall association was found to be relatively weak.

Then we decided to apply the thresholds for each indicator. If the value was higher then the threshold, we count that patient is positive by this indicator. 
ID	a-GP2 I1 IgA	a-GP2 I1 IgG	a-GP2 I4 IgA	a-GP2 I4 IgG	a-PR3 hs
Cutoff	7 U/ml	33 U/ml	9 U/ml	23 U/ml	15 U/ml

Subsequently, I applied thresholds for each indicator to categorize patients as positive or negative for each indicator. For example, if a person had at least one positive value in the isoforms of aGP2 IgA, they were classified as aGP2 IgA positive. Similar classification was done for aGP2 IgG. If the person had positivity in at least two indicators, we count that as double positivity. 

Then with the linear regression approach I checked what indicator was the best to predict disease.
and there was following results 
Feature	Score	P-Value
0	aGP2_IgA1	8.325290	0.004017
5	aGP2_IgA	6.890330	0.008836
4	PR3_pos	3.567518	0.059290
6	aGP2_IgG	1.977944	0.160004
7	double_pos	1.758549	0.185193
2	aGP2_IgG1	1.325282	0.249998
3	aGP2_IgG4	1.182471	0.277189
1	aGP2_IgA4	0.759218	0.383841


Further, I examined the correlation between significantly differentially abundant taxa and indicators with positivity. However, the correlation appeared to be weak.
Finally, I utilized a linear regression approach to identify the combination of markers that would better predict disease status, as evidenced by ROC curves. Interestingly, bacteria taxa were found to predict disease status better than GP2 positivity.
See 10_2020-023_GP2_reviewed_2.ipynb

# Species-level and ASV representation for significant genera
We also studied the significant genera by associating them with their respective species names and ASVs. This analysis was visualized using a bubble plot, providing insights into the distribution and abundance of species and ASVs within the significant genera.

To achieve this, we performed a differential abundance analysis at the ASV level, enabling a more granular understanding of microbial composition and its association with significant genera.
See 11_2020-023_diff_abundances.r, 12_2020-023-bubble_logfc.ipynb

# Literature search
G__Flavonifractor genus attracted the most interest, so I performed literature search based on this term.  A total of 224 articles were identified on PubMed, with a notable surge in publications observed in the year 2023.
The top of diseases associated with this term are diabetes, cancer, obesity

The taxa names associated with this term are eubacterium, salmonella

