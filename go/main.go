package main

import (
	"fmt"
	"math"
)

type stack struct {
    s []int
}

func (s *stack) push(v int) {
    s.s = append(s.s, v)
}

func (s *stack) pop() int {
    v := s.peek()
    s.s = s.s[:len(s.s)-1]
    return v
}

func (s *stack) peek() int {
    return s.s[len(s.s)-1]
}

func (s *stack) empty() bool {
    return len(s.s) == 0
}

func (s *stack) size() int {
    return len(s.s)
}

func dupSlice(s []int) []int {
	return append(make([]int, 0, len(s)), s...)
}

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
