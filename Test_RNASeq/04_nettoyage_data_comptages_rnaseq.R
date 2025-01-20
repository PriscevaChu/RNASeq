setwd("C:/Users/prisc/Documents/Etudes/RNA_SEQ")
library(magrittr)
library(HclDataCleaning)
library(FactoMineR)
library(factoextra)
library(Rtsne)
library(ggplot2)

# --------------------------------------------------------------------------------------------------------------------------

# Chargement données noms gènes 
names_gene <- readLines("data/gene2name.txt", encoding = "UTF-8")

# DF correspondance non / code gene 
names_gene <- data.frame(do.call(rbind, stringr::str_split(names_gene, "\t"))) %>% 
  dplyr::select(X1, X2) %>% 
  dplyr::rename(code_gene = X1, 
                nom_gene = X2)

# --------------------------------------------------------------------------------------------------------------------------

# Chragement données compte des gènes 
genes_count <- get_data("data", "GSE188678_COVID_host_classifier_gene_counts.csv", add_col_name = F, clean_col_names = F) %>% 
  dplyr::rename(code_gene = X)

# Ajouter le nom des gènes dans la base code gènes 
genes_count <- dplyr::left_join(genes_count, names_gene, by = "code_gene") %>% 
  dplyr::relocate(nom_gene, .before = code_gene)

rm(names_gene)

# --------------------------------------------------------------------------------------------------------------------------

# Chargement métadata 
meta <- readLines("data/GSE188678_series_matrix.txt", encoding = "UTF-8")
meta <- gsub('"', "", meta)
meta <- data.frame(t(data.frame(do.call(rbind, stringr::str_split(meta, "\t")))))
colnames(meta) <- do.call("paste0", list(gsub('!', "", meta[1,]), 1:80))
colnames(meta)[53] <- "id_pat"
meta <- meta[-1,]

# --------------------------------------------------------------------------------------------------------------------------

# Transpose les genes count
t_gc <- t(genes_count)[-2,]
colnames(t_gc) <- t_gc[1,] 
t_gc <- t_gc[-1,]
ncol(t_gc)
t_gc <- data.frame(t_gc) %>% 
  dplyr::mutate_all(as.numeric) %>% 
  dplyr::mutate(id_pat = rownames(t_gc)) 
  
# --------------------------------------------------------------------------------------------------------------------------

# Join : est-ce que c'est la bonne stratégie ?
all <- dplyr::left_join(t_gc, meta[,c(31, 32, 36, 38, 40:46, 48, 53)], by = "id_pat")
all[,1:19939] <- scale(all[,1:19939])

rm(t_gc, meta, genes_count)

# --------------------------------------------------------------------------------------------------------------------------

write.csv2(all, "clean_data.csv", row.names = F)

# EN PARALLELE
a <- list()
for (i in colnames(all[,1:19939])[1:1000]) {
  a <- append(a, summary(glm(as.factor(Sample_characteristics_ch142) ~ all[,i], data = all, family = binomial))$aic)
}

min(unlist(a))

summary(all[,1:19939])
res <- PCA(all[,1:6000])
fviz_pca_ind(res, col.ind = all$Sample_characteristics_ch144, label = F)
res<-Rtsne(all[,1:5000])
tSNE_df <- res$Y %>% 
  as.data.frame() %>%
  dplyr::rename(tSNE1="V1",
         tSNE2="V2") 

tSNE_df$type <- all$Sample_characteristics_ch144

ggplot(tSNE_df, aes(x = tSNE1, y = tSNE2, col = type)) +
  geom_point()


library(parallel)
system.time({
  n_cores <- detectCores(logical=FALSE)
  cl <- makeCluster(n_cores-1)
  parLapply(cl, 1:19900 , fun = function (x) glm(as.factor(Sample_characteristics_ch142) ~ all[,x], data = all, family = binomial))$aic)
   })
##    user  system elapsed 
##    0.02    0.01    4.54
stopCluster(cl)



