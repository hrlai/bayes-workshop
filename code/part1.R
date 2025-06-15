x <- rnorm(100)
y <- rnorm(100)

library(glmmTMB)

mod <- glmmTMB(y ~ 1 + x)
summary(mod)
