--用做Haskell的练习代码存放


factorial :: (Integral a) => a -> a   
factorial 0 = 1   
factorial n = n * factorial (n - 1) 
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)   
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) 
bmiTell :: (RealFloat a) => a -> a -> String   
bmiTell weight height       
	| weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"       
	| weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"       
	| weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"       
	| otherwise  = "You're a whale, congratulations!" 

--生成前n个fibonacci数的数列
dofibs :: (Num a) => Int -> [a]
dofibs n 
	| n <= 0    = []
	| n >  100  = error "too largh"
	| otherwise = take n fibs
	where fibs  = 0 : 1 : zipWith (+) fibs (tail fibs)

--返回一个数列中的最大值
maximum' :: (Ord a) => [a] -> a   
maximum' [] = error "maximum of empty list"   
maximum' [x] = x   
maximum' (x:xs) = max x (maximum' xs)


--
-- The Towers Of Hanoi
-- Haskell
-- Copyright (C) 1998 Amit Singh. All Rights Reserved.
-- http://hanoi.kernelthread.com
--
dohanoi(0, _, _, _) = []

dohanoi(n, from, to, using) = 
    dohanoi(n - 1, from, using, to) ++
        [(from, to)] ++
        dohanoi(n - 1, using, to, from)

hanoi(n) = dohanoi(n, 1, 3, 2)

head2' :: [a] -> [a]
head2' [] = error "must > 1"
head2' [x] = error "must > 1"
head2' (x:y:_) = [x,y]



