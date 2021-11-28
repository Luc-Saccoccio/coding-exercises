myLast :: [a] -> a
myLast [] = error "Impossible"
myLast [x] = x
myLast (x:xs) = solution xs
