set.seed(777)

n <- 100
x <- rnorm(n, 60, 5)
x_scaled <- scale(x)
alpha <- 1
beta <- 2
mu <- alpha + beta * x
sigma <- 5
y <- rnorm(n, mu, sigma)

pdf("slides/fig/prior-guess1.pdf", width = 3, height = 3)
par(las = 1,
    mar = c(4, 4, 0.5, 0.5))
plot(x, y,
     pch = 21,
     bg = "white",
     xlab = "X", ylab = "Y")
dev.off()

pdf("slides/fig/prior-guess2.pdf", width = 3, height = 3)
par(las = 1,
    mar = c(4, 4, 0.5, 0.5))
plot(x_scaled, y,
     pch = 21,
     bg = "white",
     xlab = "X (scaled)", ylab = "Y")
dev.off()
