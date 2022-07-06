
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
bh <- read.csv('../../data/tema4/BostonHousing.csv')

kfold_cross_val_reg <- function(df, nfolds){
  fold <- sample(1:nfolds, nrow(df), replace = TRUE)
  cat(fold)
  
  mean_sqr_errs <- sapply(1:nfolds,
                          kfold_cval_reg_iter,
                          df, fold)
  
  list('MSE' = mean_sqr_errs,
       'Overall_Mean_Sqr_Error' = mean(mean_sqr_errs),
       'Std_Mean_Sqr_Error' = sd(mean_sqr_errs))
}

kfold_cval_reg_iter <- function(k, df, fold){
  tr_ids <- !fold %in% c(k)
  test_ids <- fold %in% c(k)
  mod <- lm(MEDV ~ ., data = df[tr_ids, ])
  pred <- predict(mod, df[test_ids, ])
  sqr_errs <- (pred - df[test_ids, 'MEDV'])^2
  mean(sqr_errs)
}

res <- kfold_cross_val_reg(bh, 5)
res

# Implementando una LOOCV
loocv_reg <- function(df){
  mean_sqr_errors <- sapply(1:nrow(df),
                            loocv_reg_iter, df)
  list('MSE' = mean_sqr_errors,
       'Overall_mean_sqr_errors' = mean(mean_sqr_errors),
       'sd_mean_sqr_errors' = sd(mean_sqr_errors))
}

loocv_reg_iter <- function(k, df){
  mod = lm(MEDV ~ ., data = df[-k, ])
  pred <- predict(mod, df[k, ])
  sqr_error <- (pred - df[k, 'MEDV'])^2
  sqr_error
}

res <- loocv_reg(bh)
