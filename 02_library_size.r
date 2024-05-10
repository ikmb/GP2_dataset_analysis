library(phyloseq)
library(ggplot2)

# Load the ASV table as a dataframe
PSC_ASV_seren<- read.csv('./results/PSC_ASV_seren.csv', header = TRUE, row.names = 1)
PSC_ASV_stool<- read.csv('./results/PSC_ASV_stool.csv', header = TRUE, row.names = 1)

BSPSPC_ASV_seren<- read.csv('./results/BSPSPC_ASV_seren.csv', header = TRUE, row.names = 1)
BSPSPC_ASV_stool<- read.csv('./results/BSPSPC_ASV_stool.csv', header = TRUE, row.names = 1)


# Create a phyloseq sample data
# Assign values to Material and Group columns for each dataframe
PSC_ASV_seren$Material <- 'seren'
PSC_ASV_seren$Group <- 'PSC'

PSC_ASV_stool$Material <- 'stool'
PSC_ASV_stool$Group <- 'PSC'

BSPSPC_ASV_seren$Material <- 'seren'
BSPSPC_ASV_seren$Group <- 'BSPSPC'

BSPSPC_ASV_stool$Material <- 'stool'
BSPSPC_ASV_stool$Group <- 'BSPSPC'

# Drop other columns for meta
PSC_ASV_seren_meta <- PSC_ASV_seren[, c('Material', 'Group'), drop = FALSE]
PSC_ASV_stool_meta <- PSC_ASV_stool[, c('Material', 'Group'), drop = FALSE]

BSPSPC_ASV_seren_meta <- BSPSPC_ASV_seren[, c('Material', 'Group'), drop = FALSE]
BSPSPC_ASV_stool_meta <- BSPSPC_ASV_stool[, c('Material', 'Group'), drop = FALSE]

mata_dfs <- list(PSC_ASV_seren_meta, PSC_ASV_stool_meta, BSPSPC_ASV_seren_meta, BSPSPC_ASV_stool_meta)

# create meta samples
metasamp <- list()
for (df in mata_dfs) {
    sam_df <- sample_data(df)
    metasamp[[length(metasamp) + 1]] <- sam_df
}


# Drop other columns for counts
PSC_ASV_seren <- PSC_ASV_seren[, !(names(PSC_ASV_seren) %in% c('Material', 'Group')), drop = FALSE]
PSC_ASV_stool <- PSC_ASV_stool[, !(names(PSC_ASV_stool) %in% c('Material', 'Group')), drop = FALSE]

BSPSPC_ASV_seren <- BSPSPC_ASV_seren[, !(names(BSPSPC_ASV_seren) %in% c('Material', 'Group')), drop = FALSE]
BSPSPC_ASV_stool <- BSPSPC_ASV_stool[, !(names(BSPSPC_ASV_stool) %in% c('Material', 'Group')), drop = FALSE]

#transform to matrix
PSC_ASV_seren <- data.matrix(PSC_ASV_seren)
PSC_ASV_stool<- data.matrix(PSC_ASV_stool)

BSPSPC_ASV_seren<-data.matrix(BSPSPC_ASV_seren)
BSPSPC_ASV_stool<- data.matrix(BSPSPC_ASV_stool)

dfs <- list(PSC_ASV_seren, PSC_ASV_stool, BSPSPC_ASV_seren, BSPSPC_ASV_stool)

# create otu tables
otu_tables <- list()
for (df in dfs) {
    otu <-otu_table(df, taxa_are_rows = FALSE)
    otu_tables[[length(otu_tables) + 1]] <- otu
}

#create phyloseq object
physeq_list <- list()

# Assuming mets_dfs and dfs are lists of equal length
for (i in seq_along(metasamp)) {
  # Combine the corresponding elements from mets_dfs and dfs to create phyloseq object
  physeq <- phyloseq(otu = otu_tables[[i]], sample_data = metasamp[[i]])
  
  # Append physeq object to the list
  physeq_list[[i]] <- physeq
}
names(physeq_list) <- c('PSC_ASV_seren', 'PSC_ASV_stool', 'BSPSPC_ASV_seren', 'BSPSPC_ASV_stool')

#  Loop through each phyloseq object
for (i in seq_along(physeq_list)) {
    # Extract metadata dataframe from phyloseq object
    df <- as.data.frame(sample_data(physeq_list[[i]]))
    
    # Calculate LibrarySize
    df$LibrarySize <- sample_sums(physeq_list[[i]])
    
    # Order dataframe by LibrarySize
    df <- df[order(df$LibrarySize), ]
    
    # Add Index column
    df$Index <- seq(nrow(df))
    
    # Create the plot
    plot <- ggplot(data = df, aes(x = Index, y = LibrarySize)) + 
        geom_point() +
        scale_y_continuous(breaks = seq(0, max(df$LibrarySize), by = 5000))
    
    # Save the plot
    filename <- paste0("./results/library_size_", names(physeq_list)[i], ".jpg")
    ggsave(filename = filename, plot = plot, device = "jpg")
}
