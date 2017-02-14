package main

import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/petar/GoLLRB/llrb"
)

type CacheEntry struct {
	Count uint32
	Name  string
}

// var list []CacheEntry
var cached map[string]uint32
var tree *llrb.LLRB

func ParseLine(line string) (count uint32, name string) {
	// TODO: More sane error handling

	n, err := fmt.Sscanf(line, "%d %s", &count, &name)

	if err != nil {
		panic(err)
	}
	if n != 2 {
		panic("Invalid cache file")
	}

	return
}

type Entry struct {
	Name  string
	Count uint32
}

func (a Entry) Less(b llrb.Item) bool {
	return a.Count < b.(Entry).Count
}

func main() {
	start := time.Now()

	cmd := exec.Command("dmenu")
	dmenu_in, err := cmd.StdinPipe()
	if err != nil {
		fmt.Println(err)
		return
	}

	dmenu_out, err := cmd.StdoutPipe()
	if err != nil {
		fmt.Println(err)
		return
	}

	err = cmd.Start()
	if err != nil {
		fmt.Println(err)
		return
	}

	elapsed := time.Since(start)

	fmt.Printf("Time before dmenu started: %v\n", elapsed)

	cached = make(map[string]uint32)
	tree = llrb.New()

	mcu_cache, err := os.Open("/home/maestro/.cache/dmenu_go")

	if err != nil {
		fmt.Println(err)
		return
	}
	defer mcu_cache.Close()

	cache, err := os.Open("/home/maestro/.cache/dmenu_run")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer cache.Close()

	// Read the MCU cache
	reader := bufio.NewReader(mcu_cache)
	for {
		line, err := reader.ReadString('\n')
		if err == io.EOF {
			break
		} else if err != nil {
			fmt.Println(err)
			return
		}

		line = line[0 : len(line)-1]
		count, name := ParseLine(line)
		dmenu_in.Write([]byte(name))
		dmenu_in.Write([]byte("\n"))

		cached[name] = count
		tree.InsertNoReplace(Entry{name, count})
	}

	// Read the standard dmenu cache
	reader = bufio.NewReader(cache)
	for {
		line, err := reader.ReadBytes('\n')
		if err == io.EOF {
			break
		} else if err != nil {
			fmt.Println(err)
			return
		}

		// Skip anything that was present in the MCU cache
		if _, ok := cached[string(line[0:len(line)-1])]; ok {
			continue
		}

		dmenu_in.Write(line)
	}

	dmenu_in.Close()

	out, err := ioutil.ReadAll(dmenu_out)
	if err != nil {
		fmt.Println(err)
		return
	}

	done := make(chan bool)

	if len(out) == 0 {
		return
	}

	args := strings.Split(string(out[0:len(out)-1]), " ")

	go func() {
		mcu_cache, err = os.OpenFile("/home/maestro/.cache/dmenu_go", os.O_WRONLY, os.ModePerm)
		if err != nil {
			fmt.Println(err)
			return
		}

		used := false
		for tree.Len() > 0 {
			i := tree.DeleteMax()
			e := i.(Entry)
			if !used && args[0] == e.Name {
				used = true
				e.Count += 1
			}
			// fmt.Println(e.Count, e.Name)
			fmt.Fprintf(mcu_cache, "%7d %s\n", e.Count, e.Name)
		}

		if !used {
			fmt.Fprintf(mcu_cache, "%7d %s\n", 1, args[0])
		}

		done <- true
	}()

	cmd = exec.Command(args[0], args[1:]...)

	if cmd.Run() != nil {
		return
	}

	<-done

	cmd.Wait()

	os.Exit(0)
}
