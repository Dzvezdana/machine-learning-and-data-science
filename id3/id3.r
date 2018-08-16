rm(list=ls())
library(data.tree)

#Insert the features
Outlook<−c(’Sunny’,’Sunny’,’Overcast’,’Rain’,’Rain’,’Rain’,’Overcast’,’Sunny’,’Sunny’,’Rain’,’Sunny’,’Overcast’,’Overcast’,’Rain’)
Temperature<−c(’Hot’,’Hot’,’Hot’,’Mild’,’Cool’,’Cool’,’Cool’,’Mild’,’Cool’,’Mild’,’Mild’,’Mild’,’Hot’,’Mild’)
Humidity<−c(’High’,’High’,’High’,’High’,’Normal’,’Normal’,’Normal’,’High’,’Normal’,’Normal’,’Normal’,’High’,’Normal’,’High’)
Wind<−c(’Weak’,’Strong’,’Weak’,’Weak’,’Weak’,’Strong’,’Strong’,’Weak’,’Weak’,’Weak’,’Strong’,’Strong’,’Weak’,’Strong’)
Play<−c(’No’,’No’,’Yes’,’Yes’,’Yes’,’No’,’Yes’,’No’,’Yes’,’Yes’,’Yes’,’Yes’,’Yes’,’No’)
#Bind all features of the test data 
train_data<−data.frame(Outlook,Temperature,Humidity,Wind,Play)

Outlook<−c(’Sunny’,’Rain’,’Overcast’,’Sunny’,’Sunny’,’Sunny’,’Overcast’,’Rain’,’Sunny’,’Sunny’,’Sunny’,’Sunny’,’Sunny’,’Overcast’)
Temperature<−c(’Mild’,’Cool’,’Hot’,’Cool’,’Cool’,’Cool’,’Cool’,’Hot’,’Hot’,’Cool’,’Hot’,’Cool’,’Mild’,’Mild’)
Humidity<−c(’High’,’High’,’Normal’,’Normal’,’Normal’,’High’,’High’,’High’,’Normal’,’High’,’High’,’Normal’,’Normal’,’Normal’)
Wind<−c(’Strong’,’Weak’,’Strong’,’Weak’,’Strong’,’Weak’,’Strong’,’Strong’,’Strong’,’Strong’,’Strong’,’Weak’,’Weak’,’Weak’)

# Bind all features of the train data
test <− data.frame(Outlook,Temperature,Humidity,Wind)

# Check if one of the features is completly pure
PureNode <- function(data) {
    length(unique(data[, ncol(data)])) == 1
}

# Calculate the entropy
Entropy <- function(S) {
    res <- S/sum(S) * log2(S/sum(S))
    res[S == 0] <- 0
    -sum(res)
}

# Calculate the information gain
Information_Gain <- function(feat) {
    entropyBefore <- Entropy(colSums(feat))
    s <- rowSums(feat)
    entropyAfter <- sum(s/sum(s) * apply(feat, MARGIN = 1, FUN = Entropy))
    Information_Gain <- entropyBefore - entropyAfter
    return(Information_Gain)
}

TrainID3 <- function(node, data) {
    
    node$obsCount <- nrow(data)
    
    # if the data set is pure then create a leaf with the name of the pure
    # feature if the data set is completly pure stop
    if (PureNode(data)) {
        child <- node$AddChild(unique(data[, ncol(data)]))
        node$feature <- tail(names(data), 1)
        child$obsCount <- nrow(data)
        child$feature <- ""
    } else {
        # if the data set is not pure calculate the information gain
        ig <- sapply(colnames(data)[-ncol(data)], 
                     function(x) Information_Gain
                     (table(data[,x], data[, ncol(data)])))
        
        # chose the feature with the highest information gain if more than one
        # feature have the same information gain, then take the first one
        feature <- names(which.max(ig))
        node$feature <- feature
        #Create a subset from a feature
        childObs <- split(data[, names(data) != feature, drop = FALSE], 
                          data[,feature], drop = TRUE)
        
        for (i in 1:length(childObs)) {
            # construct a child
            child <- node$AddChild(names(childObs)[i])
            
            # call the algorithm recursively
            TrainID3(child, childObs[[i]])
        }
    }
}

# Build the tree using the train data and print it
tree <- Node$new("train_data")
TrainID3(tree, train_data)
print(tree, "feature")

# Prediction
Predict <− function(tree, features) {
if(tree$children[[1]]$isLeaf)return (tree $ children[[1]]$name)
child <− tree$children[[features[[tree$feature]]]]
return (Predict(child, features))}

# Make a prediction for each row in the test data and print the resulst
for (i in 1 : nrow(test)) {
val = Predict(tree, test[i,])
print(val)}