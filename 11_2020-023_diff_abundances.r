library(ANCOMBC)
library(tidyverse)
library(DT)

set.seed(662)

#load counts
rarefied_genus <- read.csv('./results/norm_merged_ASV_abundances_filtered_stool.csv', row.names = 1)


#create meta 
# Assuming 'sample_id' is the column name
rarefied_genus$Material <- ifelse(grepl("srn", rownames(rarefied_genus)), "seren", "stool")
rarefied_genus$Group <- ifelse(grepl("PSC", rownames(rarefied_genus)), "PSC", "BSPSPC")

#subset tables
meta_df_sub <- subset(rarefied_genus, select = c(Material, Group))

#subset by comparison pairs
#by group
rg_stool <- rarefied_genus[rarefied_genus$Material == 'stool', ]
rg_stool <- subset(rg_stool, select = -c(Material, Group))

meta_stool <- meta_df_sub[meta_df_sub$Material == 'stool', ]


#Create tse object
count_matrix <- as.matrix(t(rg_stool))
counts <- S4Vectors::SimpleList(counts = count_matrix)
metadata= S4Vectors::DataFrame(meta_stool)
tse <- TreeSummarizedExperiment::TreeSummarizedExperiment(assays = counts, colData = metadata)

# Run ancombc2 function
output <- ancombc2(data = tse,
                   assay_name = "counts", 
                   tax_level = NULL,
                   fix_formula = "Group",  
                   rand_formula = NULL,
                   p_adj_method = "holm", 
                   pseudo_sens = TRUE,
                   prv_cut = 0.10, 
                   lib_cut = 1000, 
                   s0_perc = 0.05,
                   group = "Group",  
                   struc_zero = TRUE, 
                   neg_lb = FALSE,
                   alpha = 0.05, 
                   n_cl = 2, 
                   verbose = TRUE,
                   global = TRUE, 
                   pairwise = TRUE, 
                   dunnet = TRUE, 
                   trend = TRUE,
                   iter_control = list(tol = 1e-2, max_iter = 20, verbose = TRUE),
                   em_control = list(tol = 1e-5, max_iter = 100),
                   lme_control = lme4::lmerControl(),
                   mdfdr_control = list(fwer_ctrl_method = "holm", B = 100),
                   trend_control = list(contrast = list(matrix(c(1, 0, -1, 1),
                                                            nrow = 2,
                                                            byrow = TRUE)),
                                        node = list(2),  # Specify the contrast for all nodes
                                        solver = "ECOS",
                                        B = 10))


res_prim  <-  output$res
write.csv(res_prim, file = "./results/2020-023_res_prim_stool_ASV.csv", row.names = TRUE)
