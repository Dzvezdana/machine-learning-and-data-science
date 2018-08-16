rm(list = ls())

# Load the data
points <- data.frame(ID = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", 
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"), x = c(3, 4, 2.1, 4, 7, 
    3, 6.1, 7, 4, 3, 6.2, 7, 5, 3.5, 2.5, 3.5, 5.5, 6, 0.5, 0.8), y = c(6.1, 
    2, 5, 6, 3, 5, 4, 2, 1.5, 2, 2, 3, 5, 4.5, 6, 5.5, 4.5, 1, 1.5, 1.2))

# Center points A,C,F,M
start <- rbind(c(3, 6.1), c(2.1, 5), c(3, 5), c(5, 5))

# Calculte Euclidean distance between the points and the center points
myEuclid <- function(data, centers) {
    distanceMatrix <- matrix(NA, nrow = dim(data)[1], ncol = dim(centers)[1])
    for (i in 1:nrow(centers)) {
        distanceMatrix[, i] <- sqrt(rowSums(t(t(data) - centers[i, ])^2))
    }
    distanceMatrix
}

# K-means algorithm
myKmeans <- function(x, centers, distFun, nItter = 3) {
    clusterHistory <- vector(nItter, mode = "list")
    centerHistory <- vector(nItter, mode = "list")
    
    for (i in 1:nItter) {
        distsToCenters <- distFun(x, centers)
        clusters <- apply(distsToCenters, 1, which.min)
        centers <- apply(x, 2, tapply, clusters, mean)
        clusterHistory[[i]] <- clusters
        centerHistory[[i]] <- centers
    }
    
    list(clusters = clusterHistory, centers = centerHistory)
}

k <- myKmeans(points[, 2:3], start, myEuclid, nItter = 3)

par(mfrow = c(2, 2))
for (i in 1:3) {
    plot(points[, 2:3], col = k$clusters[[i]], main = paste("itteration:", i), 
        xlab = "x", ylab = "y", ylim = c(0, 7))
    points(k$centers[[i]], cex = 3, pch = 19, col = 1:nrow(k$centers[[i]]))
}

# Check results
k <- kmeans(points[, 2:3], start)
k$centers

plot(points[, 2:3], col = k$cluster, pch = 3, ylim = c(1, 7))
points(k[["centers"]], pch = 4, cex = 2, col = "blue")
text(points$x, points$y, labels = points$ID, cex = 1, pos = 3)