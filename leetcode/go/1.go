func twoSum(nums []int, target int) []int {
  m := make(map[int]int)
  for i, x := range nums {
    if j, ok := m[target-x]; ok {
      return []int{i, j}
    }
    m[x] = i
  }
  return nil
}
