# Read the text file, (column names already deleted)
image = read.csv("C:/Users/Arsovska/Desktop/RGB_row_shuffled_image.txt", sep = " ", header = FALSE, 
    comment.char = "r")
image = image[-1]
# Save the original rows ordering
rownames(image) = paste("", seq(1, length(data[, 1])), sep = "")

library(seriation)

# Calculate distance
d = dist(data)

# Hierarhical clustering - min distance
hc_s = hclust(d, method = "single")
get_order(hc_s)
result1 = rownames(image[get_order(hc_s), ])
result1 <- as.numeric(unlist(result1))

# Transform the row names
uns_rows1 <- ifelse(result1 >= 100, paste("R00", result1, sep = ""), ifelse((result1 <= 
    99 & result >= 10), paste("R000", result1, sep = ""), ifelse(result1 <= 
    9, paste("R0000", result1, sep = ""), result1)))

write.table(uns_rows1, "C:/Users/Arsovska/Desktop/seriation1.txt", row.names = F, 
    col.names = F, quote = F)

# Hierarhical clustering - max distance
hc_c = hclust(d, method = "complete")
get_order(hc_c)
result2 = rownames(image[get_order(hc_c), ])
result2 <- as.numeric(unlist(result2))
uns_rows2 <- ifelse(result2 >= 100, paste("R00", result2, sep = ""), ifelse((result2 <= 
    99 & result2 >= 10), paste("R000", result2, sep = ""), ifelse(result2 <= 
    9, paste("R0000", result2, sep = ""), result2)))

write.table(uns_rows2, "C:/Users/Arsovska/Desktop/seriation2.txt", row.names = F, 
    col.names = F, quote = F)