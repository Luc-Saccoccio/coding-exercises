-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
-- Find the largest palindrome made from the product of two 3-digit numbers.


problem_4 = maximum [x | y<-[100..999], z<-[y..999], let x=y*z, let s=show x in s==reverse s]

main = do
    print problem_4
