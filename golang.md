# Go Programming Notes

## Build an executable
```zsh
go build go_source_file.go
```


## Initialize a module

### 1. Run `go mod init`
```zsh
go mod init github.com/andypayne/goproject
```

### 2. Create `main.go`
Something like:
```go
package main

import "fmt"

func main() {
  fmt.Println("Hello from goproject")
}
```

### 3. Run it
```zsh
go run github.com/andypayne/goproject
```


## Help Documentation

```zsh
go doc json.Decoder.decode
```
