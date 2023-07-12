package main

import "os"
import "fmt"
import "strings"
import "strconv"

func usage() {
    fmt.Println("Usage: backlight [+|-]<percents>")
    os.Exit(1)
}

const MIN_BRIGHTNESS = 1
const MAX_BRIGHTNESS = 96000
const CUR_BRIGHTNESS_PATH = "/sys/class/backlight/intel_backlight/brightness"

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

    bytes, _ := os.ReadFile(CUR_BRIGHTNESS_PATH)
    text := strings.TrimSpace(string(bytes))
    curr, _ := strconv.Atoi(text)
    next := int(float64(curr) * koef)
    if next < MIN_BRIGHTNESS {
        next = MIN_BRIGHTNESS
    } else if next > MAX_BRIGHTNESS {
        next = MAX_BRIGHTNESS
    }
    //fmt.Println(text, curr, next)

    new_text := strconv.Itoa(next) + "\n"

    err := os.WriteFile(CUR_BRIGHTNESS_PATH, []byte(new_text), 0644)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(curr, next)
}
