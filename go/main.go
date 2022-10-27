package main

import (
	"fmt"
	"math"
)

func abs(a int) int {
	if a < 0 {
		return a * -1
	}
	return a
}

func sum(a ...int) (r int) {
	for _, n := range a {
		r += n
	}
	return
}

func max(a ...int) (r int) {
	r = math.MinInt
	for i := range a {
		if a[i] > r {
			r = a[i]
		}
	}
	return
}

func min(a ...int) (r int) {
	r = math.MaxInt
	for i := range a {
		if a[i] < r {
			r = a[i]
		}
	}
	return
}

func main() {
	fmt.Println("hello world")
}
