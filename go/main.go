package main

import (
	"fmt"
	"hash/fnv"
	"math"
	"math/big"
	"math/bits"
	"sort"
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

func (s *stack) popFront() int {
	v := s.front()
	s.s = s.s[1:]
	return v
}

func (s *stack) pushFront(v int) {
	s.s = append(append(make([]int, 0, len(s.s)+1), v), s.s...)
}

func (s *stack) front() int {
	return s.s[0]
}

func (s *stack) empty() bool {
	return len(s.s) == 0
}

func (s *stack) size() int {
	return len(s.s)
}

func factorial(n int64) int {
	return int(new(big.Int).MulRange(1, n).Int64())
}

func dupSlice(s []int) []int {
	return append(make([]int, 0, len(s)), s...)
}

func sortIntSlice(s []int) []int {
	sort.Ints(s)
	return s
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

// hash a string of a-z chars to uint32
func hashLowercaseAlpha(s string) uint32 {
	var mi uint32
	m := make([]byte, 26)

	for i := range s {
		c := uint64(s[i] - 'a')
		mi |= uint32(1 << c)
		m[c]++
	}

	h := fnv.New32a()
	for mi > 0 {
		// alternative implementations: https://stackoverflow.com/questions/757059/position-of-least-significant-bit-that-is-set
		i := bits.TrailingZeros32(mi)
		h.Write([]byte{byte(i), m[i]})
		mi &= mi - 1 // clear trailing bit
	}
	return h.Sum32()
}
