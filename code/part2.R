library(tidyverse)   # for cleaner codes
library(reshape2)    # for pivoting matrix to dataframe
library(mvabund)     # for dataset
library(brms)        # for fitting Bayesian model
library(bayesplot)   # for visualising the posteriors
library(tidybayes)   # for post-processing the posteriors



# Data --------------------------------------------------------------------

# we will use the spider dataset from the mvabund package
data("spider")

# first we will manipulate the data, which comes in matrices, to a 
# long-format dataframe, because this is more compatible with the 
# brms modelling package; note that in other JSDM packages such as
# boral and gllvm you would use wide format / matrices as inputs instead

# site-environment data
x <- 
    spider$x %>% 
    as.data.frame() %>% 
    rownames_to_column("Site")

# scale environmental predictors to promote model convergence
# note: we won't be going into details about centering and scaling, but this
# is a very common and important step, so we should probably chat about it
# in class on the whiteboard
x_scaled <- 
    x %>% 
    mutate_at(vars(-Site), ~ as.numeric(scale(.)))

# change the site-species abundance matrix into a long-format dataframe
# then convert abundances to presence-absence to simplify our analysis
# then merge with the environmental predictors
dat <- 
    melt(spider$abund,
         varnames = c("Site", "Species"),
         value.name = "N") %>% 
    mutate(Pres = as.numeric(N > 0),
           Site = as.character(Site)) %>% 
    left_join(x)





# Model -------------------------------------------------------------------

# model multiple species' presence-absence across sites as a function of
# a single environmental predictor, soil dryness (for simplicity)
mod <- 
    brm(
        Pres ~ 1 + soil.dry + (1 + soil.dry | Species) + (1 | Site),
        family = bernoulli(),
        data = dat,
        cores = 4
    )

# the Bayesian inference will take a few seconds (no longer than a few minutes)
# to run; meanwhile, let's think about:
# - can you translate the model formula to mathematical expression?
# - can you translate the model formula to graphs?
# - recall what is the Bernoulli distribution ("family") and what is
#   canonical link function?



# Diagnostics -------------------------------------------------------------

# check that model has converged: Rhat, warnings etc.
summary(mod)

# check that chains have mixed well: trace plots
mcmc_trace(mod, regex_pars = "^b_")          # fixed effects
mcmc_trace(mod, regex_pars = "^r_Site")      # random site effects
mcmc_trace(mod, regex_pars = "^r_Species")   # random species effects
mcmc_trace(mod, regex_pars = "^sd_|^cor_")   # std. deviations of random terms

# examine posterior summaries: intervals
mcmc_intervals(mod, regex_pars = "^b_|^r_Species")

# examine posterior distributions: densities
mcmc_areas_ridges(mod, regex_pars = "^b_|^r_Species")

# compare fitted and empirical distributions
pp_check(mod, ndraws = 100)

# overall the diagnostics should be performing pretty well here,
# but in real life your model and data are going to less friendly than this!




# Results -----------------------------------------------------------------

# we will only go over an example of post-processing
# that is calculating the estimates of species-specific slopes
# the random species slopes we got out of the model are actually *deviation*
# from the fixed slope, not their actual slopes; to get them, we need to
# add up fixed + random slopes;
# although you can do so using the function coef(mod)$Species, 
# we will do it manually here so you have the skill to perform all sorts of
# calculation from the posterior distributons in the future

# tips: get variable names from a fitted brms model with variables(mod)

coef_spp <- 
    spread_draws(mod, 
                 b_Intercept,
                 b_soil.dry,
                 r_Species[Species, Param]) %>% 
    pivot_wider(names_from = Param,
                values_from = r_Species,
                names_prefix = "r_") %>% 
    mutate(Intercept = b_Intercept + r_Intercept,
           soil.dry  = b_soil.dry + r_soil.dry) %>% 
    # for each species, summarise its intercept and slope for plotting 
    # them out as effect sizes
    # there are many option; we'll use the median and 90% credible intervals
    group_by(Species) %>% 
    median_qi(Intercept, soil.dry,
              .width = 0.90)

# visualise
# intercepts
coef_spp %>% 
    mutate(Species = fct_reorder(Species, Intercept)) %>% 
    ggplot() +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_errorbarh(aes(y = Species, 
                       xmin = Intercept.lower, 
                       xmax = Intercept.upper),
                   height = 0) +
    geom_point(aes(Intercept, Species)) +
    theme_bw()

# slopes
coef_spp %>% 
    mutate(Species = fct_reorder(Species, soil.dry)) %>% 
    ggplot() +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_errorbarh(aes(y = Species, 
                       xmin = soil.dry.lower, 
                       xmax = soil.dry.upper),
                   height = 0) +
    geom_point(aes(soil.dry, Species)) +
    theme_bw()

# intercepts vs. slopes (to illustrate correlated random terms)
coef_spp %>% 
    ggplot() +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_hline(yintercept = 0, linetype = 2) +
    geom_errorbarh(aes(y = soil.dry, 
                       xmin = Intercept.lower, 
                       xmax = Intercept.upper),
                   height = 0) +
    geom_errorbar(aes(x = Intercept, 
                       ymin = soil.dry.lower, 
                       ymax = soil.dry.upper),
                   width = 0) +
    geom_point(aes(Intercept, soil.dry)) +
    theme_bw()
