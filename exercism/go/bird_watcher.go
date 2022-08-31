package birdwatcher

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	res := 0
	for i := range birdsPerDay {
		res += birdsPerDay[i]
	}
	return res
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	offset := (week - 1) * 7
	return TotalBirdCount(birdsPerDay[offset : offset+7])
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	for i := range birdsPerDay {
		if i&1 == 0 {
			birdsPerDay[i]++
		}
	}
	return birdsPerDay
}
