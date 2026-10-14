### pa_ringbuffer

[Portaudio RingBuffer](https://portaudio.com/docs/v19-doxydocs-dev/pa__ringbuffer_8h.html) bindings for [Odin](https://odin-lang.org/)

### Example
```odin

import pa_rb "./pa_ringbuffer"

rb := pa_rb.RingBuffer{}
rb_data := make([]u8, RB_SIZE * size_of(f32))
pa_rb.InitializeRingBuffer(&rb, pa_rb.rb_size_t(size_of(f32)), pa_rb.rb_size_t(RB_SIZE), raw_data(rb_data))

pa_rb.WriteRingBuffer(&rb, raw_data(input), pa_rb.rb_size_t(len(input)))
```

`rb_size_t` follows `ring_buffer_size_t` in `pa_ringbuffer.h`, `i32` on macOS and iOS, `c.long` elsewhere (64-bit on Linux and Android), so the struct layout matches the C library.

### Build portaudio ringbuffer on MacOS/Linux
```sh
clang pa_ringbuffer.c pa_ringbuffer.h -c -O2 -Os -fPIC
ar rcs pa_ringbuffer.a pa_ringbuffer.o
```

### Building on Windows with MSVC
```
cl /c /O2 /Fo:pa_ringbuffer.obj pa_ringbuffer.c
lib /OUT:pa_ringbuffer.lib pa_ringbuffer.obj
```
