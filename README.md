### pa_ringbuffer

[Portaudio RingBuffer](https://portaudio.com/docs/v19-doxydocs-dev/pa__ringbuffer_8h.html) bindings for [Odin](https://odin-lang.org/)

### Example
```odin

import pa_rb "./pa_ringbuffer"

rb := pa_rb.RingBuffer{}
rb_data := make([]u8, RB_SIZE * size_of(f32))
pa_rb.InitializeRingBuffer(&rb, i32(size_of(f32)), i32(RB_SIZE), raw_data(rb_data))

pa_rb.WriteRingBuffer(&rb, raw_data(input), i32(len(input)))

```
