package main

import "os"
import "fmt"
import "strings"
import "strconv"

func usage() {
    fmt.Println("Usage: backlight [+|-]<percents>")
    os.Exit(1)
}

func main() {
    if len(os.Args) < 2 {
        usage()
    }
    cmd := os.Args[1]
    sign := 1.0
    if cmd[0] == '+' {
        sign = 1.0
    } else if cmd[0] == '-' {
        sign = -1.0
    } else {
        usage()
    }

    value, _ := strconv.ParseFloat(cmd[1:], 64)

    koef := 1.0 + sign * (value / 100)
    //fmt.Println(cmd, sign, value, koef)

    path := "/sys/class/backlight/intel_backlight/brightness"
    bytes, _ := os.ReadFile(path)
    text := strings.TrimSpace(string(bytes))
    curr, _ := strconv.Atoi(text)
    next := int(float64(curr) * koef)
    //fmt.Println(text, curr, next)

    new_text := strconv.Itoa(next) + "\n"

    err := os.WriteFile(path, []byte(new_text), 0644)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(curr, next)
}
