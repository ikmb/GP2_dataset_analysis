library(ANCOMBC)
library(tidyverse)
library(DT)

set.seed(662)

#load counts
rarefied_genus <- read.csv('./results/norm_merged_genus_abundances_filtered.csv', row.names = 1)

#drop taxa which have 0 counts in more then 90% of samples
zero_percentage <- colMeans(rarefied_genus == 0)
threshold <- 0.90
taxa_to_exclude <- names(zero_percentage[zero_percentage >= threshold])
rarefied_genus <- rarefied_genus[, !(names(rarefied_genus) %in% taxa_to_exclude)]


#create meta 
# Assuming 'sample_id' is the column name
rarefied_genus$Material <- ifelse(grepl("srn", rownames(rarefied_genus)), "seren", "stool")
rarefied_genus$Group <- ifelse(grepl("PSC", rownames(rarefied_genus)), "PSC", "BSPSPC")
rarefied_genus$Combined <- paste(rarefied_genus$Group, rarefied_genus$Material, sep = "_")

#subset tables
meta_df_sub <- subset(rarefied_genus, select = c(Material, Group, Combined))

#subset by comparison pairs
#by group
rg_seren <- rarefied_genus[rarefied_genus$Material == 'seren', ]
rg_seren <- subset(rg_seren, select = -c(Material, Group, Combined))
meta_seren <- meta_df_sub[meta_df_sub$Material == 'seren', ]


#Create tse object
count_matrix <- as.matrix(t(rg_seren))
counts <- S4Vectors::SimpleList(counts = count_matrix)
metadata= S4Vectors::DataFrame(meta_seren)
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

tab_zero  <-  output$zero_ind
tab_zero %>%
    datatable(caption = "The detection of structural zeros")
write.csv(tab_zero, file = "./results/2020-023_tab_zero_seren.csv", row.names = TRUE)

res_prim  <-  output$res
write.csv(res_prim, file = "./results/2020-023_res_prim_seren.csv", row.names = TRUE)

res_global  <-  output$res_global
write.csv(res_global , file = "./results/2020-023_res_global_seren.csv", row.names = TRUE)

res_pair  <-  output$res_pair
write.csv(res_pair, file = "./results/2020-023_res_pair_seren.csv", row.names = TRUE)

res_dunn  <-  output$res_dunn
write.csv(res_dunn, file = "./results/2020-023_res_dunn_seren.csv", row.names = TRUE)

res_trend  <-  output$res_trend
write.csv(res_trend, file = "./results/2020-023_res_trend_seren.csv", row.names = TRUE)