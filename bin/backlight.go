package main

import "os"
import "fmt"
import "strings"
import "strconv"
import "unicode"

func usage() {
    fmt.Println("Usage: backlight [+|-]<percents>")
    os.Exit(1)
}

const CUR_BRIGHTNESS_PATH = "/sys/class/backlight/intel_backlight/brightness"
const MAX_BRIGHTNESS_PATH = "/sys/class/backlight/intel_backlight/max_brightness"

func ReadInt(path string) (int, error) {
    bytes, err := os.ReadFile(path)
    if err != nil {
        return 0, err
    }
    text := strings.TrimSpace(string(bytes))
    value, err := strconv.Atoi(text)
    return value, err
}

func main() {
    if len(os.Args) < 2 {
        usage()
    }
    cmd := os.Args[1]
    char := rune(cmd[0])
    sign := 0.0
    if cmd[0] == '+' {
        sign = 1.0
    } else if cmd[0] == '-' {
        sign = -1.0
    } else if !unicode.IsDigit(char) {
        usage()
    }

    max_value, err := ReadInt(MAX_BRIGHTNESS_PATH)
    if max_value < 100 || err != nil {
        fmt.Printf("Error reading max brightness(%d): %s\n", max_value, err)
        os.Exit(1)
    }

    input := cmd[1:]
    if sign == 0.0 {
        input = cmd
    }
    value, err := strconv.ParseFloat(input, 64)
    if err != nil {
        fmt.Printf("Error parsing value '%s': %s\n", input, err)
        os.Exit(1)
    }

    curr, err := ReadInt(CUR_BRIGHTNESS_PATH)
    if err != nil {
        fmt.Printf("Error reading brightness(%d): %s\n", curr, err)
        os.Exit(1)
    }

    next := curr
    if sign == 0.0 {
        next = int(float64(max_value) * value / 100)
    } else {
        next = int(float64(curr) * (100 + sign * value) / 100)
    }

    if next < 1 {
        next = 1
    } else if next > max_value {
        next = max_value
    }
    //fmt.Println(text, curr, next)

    new_text := strconv.Itoa(next) + "\n"

    err = os.WriteFile(CUR_BRIGHTNESS_PATH, []byte(new_text), 0644)
    if err != nil {
        fmt.Printf("Error writing brightness(%d): %s\n", next, err)
    } else {
        fmt.Printf("Brightness set to %d of %d, was %d\n", next, max_value, curr)
    }
}
