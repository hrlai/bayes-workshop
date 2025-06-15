# Workshop material for *Introduction to Bayesian Ecological Modelling*

*Under construction. More to come!*

This workshop is designed for a small group size to work in pairs, in a room 
with whiteboard. It has a [*Statistical Rethinking*](https://xcelab.net/rm/) 
(McElreath 2020) flavour to it, i.e., we are revisiting statistical tools 
and concepts rather than learning from scratch.

## Prerequisite

1. Undergraduate-level introductory biostatistics is useful, but not necessary
2. Basic `R` programming: you've loaded and analysed some ecological
data before 

## Preparation

1. Please install the `brms` package following instructions [here](https://github.com/paul-buerkner/brms?tab=readme-ov-file#faq). 
After installation, please double check that you could run some of the example
codes in the helpfile `?brm`.
2. Also install the `mvabund` package by `install.packages("mvabund")`
2. To facilitate our discussion sessions, it would be great if you could prepare
a dataset or research question that you're considering to analyse with 
Bayesian inference.
3. Laptop
4. Pen and paper

## Further readings

### On Bayesian inference

McElreath, R. (2020). Statistical rethinking: A bayesian course with examples in R and stan. In Statistical Rethinking: A Bayesian Course with Examples in R and Stan (Second ed.). CRC Press. https://doi.org/10.1201/9781315372495

Banner, K. M., Irvine, K. M., & Rodhouse, T. J. (2020). The Use of Bayesian Priors in Ecology: The Good, The Bad, and The Not Great. Methods in Ecology and Evolution, 11(8), 882–889. https://doi.org/10.1111/2041-210x.13407

Clark, J. S. (2005). Why environmental scientists are becoming Bayesians. Ecology Letters, 8(1), 2–14. https://doi.org/10.1111/j.1461-0248.2004.00702.x

Monnahan, C. C., Thorson, J. T., & Branch, T. A. (2017). Faster estimation of Bayesian models in ecology using Hamiltonian Monte Carlo. Methods in Ecology and Evolution, 8(3), 339–348. https://doi.org/10.1111/2041-210X.12681

Bürkner, P. C. (2017). brms: An R package for Bayesian multilevel models using Stan. Journal of Statistical Software, 80(1), 1–28. https://doi.org/10.18637/jss.v080.i01

Gelman, A., Vehtari, A., Simpson, D., Margossian, C. C., Carpenter, B., Yao, Y., Kennedy, L., Gabry, J., Bürkner, P.-C., & Modrák, M. (2020). Bayesian Workflow. http://arxiv.org/abs/2011.01808

Gabry, J., Simpson, D., Vehtari, A., Betancourt, M., & Gelman, A. (2019). Visualization in Bayesian workflow. Journal of the Royal Statistical Society. Series A: Statistics in Society, 182(2), 389–402. https://doi.org/10.1111/rssa.12378

### On joint species distribution modelling

Hui, F. K. C. (2016). BORAL – Bayesian Ordination and Regression Analysis of Multivariate Abundance Data in R. Methods in Ecology and Evolution, 7(6), 744–750. https://doi.org/10.1111/2041-210X.12514

Ovaskainen, O., Tikhonov, G., Norberg, A., Guillaume Blanchet, F., Duan, L., Dunson, D., Roslin, T., & Abrego, N. (2017). How to make more out of community data? A conceptual framework and its implementation as models and software. Ecology Letters, 20(5), 561–576. https://doi.org/10.1111/ele.12757

Warton, D. I., Blanchet, F. G., O’Hara, R. B., Ovaskainen, O., Taskinen, S., Walker, S. C., & Hui, F. K. C. (2015). So Many Variables: Joint Modeling in Community Ecology. Trends in Ecology and Evolution, 30(12), 766–779. https://doi.org/10.1016/j.tree.2015.09.007

Niku, J., Hui, F. K. C., Taskinen, S., & Warton, D. I. (2019). gllvm: Fast analysis of multivariate abundance data with generalized linear latent variable models in r. Methods in Ecology and Evolution, 10(12), 2173–2182. https://doi.org/10.1111/2041-210X.13303

Jamil, T., Ozinga, W. A., Kleyer, M., & Ter Braak, C. J. F. (2013). Selecting traits that explain species-environment relationships: A generalized linear mixed model approach. Journal of Vegetation Science, 24(6), 988–1000. https://doi.org/10.1111/j.1654-1103.2012.12036.x

Vesk, P. A. (2013). How traits determine species responses to environmental gradients. Journal of Vegetation Science, 24(6), 977–978. https://doi.org/10.1111/jvs.12117

## Useful `R` packages

`brms` is a good starting point to transition from classic inference to Bayesian inference.

`boral` and `gllvm` are my go-to packages for fitting JSDMs.

`greta` is in-development but my go-to for highly customised Bayesian models --- for more advanced users.

`bayesplot` and `tidybayes` are good for post-processing and examining model outputs.