package pa_ringbuffer


when ODIN_OS == .Darwin || ODIN_OS == .Linux {
	// Building on Mac:
	//    clang pa_ringbuffer.c pa_ringbuffer.h -c -O2 -Os -fPIC
	//    ar rcs pa_ringbuffer.a pa_ringbuffer.o
	foreign import pa_ringbuffer "pa_ringbuffer.a"

} else when ODIN_OS == .Windows {
	// Building on Windows with MSVC:
	//  cl /c /O2 /Fo:pa_ringbuffer.obj pa_ringbuffer.c
	//  lib /OUT:pa_ringbuffer.lib pa_ringbuffer.obj
	foreign import pa_ringbuffer "pa_ringbuffer.lib"
}


rb_size_t :: i32

RingBuffer :: struct {
	bufferSize:       rb_size_t,
	writeIndex:       rb_size_t,
	readIndex:        rb_size_t,
	bigMask:          rb_size_t,
	smallMask:        rb_size_t,
	elementSizeBytes: rb_size_t,
	buffer:           ^u8,
}

@(default_calling_convention = "c", link_prefix = "PaUtil_")
foreign pa_ringbuffer {

	InitializeRingBuffer :: proc(rbuf: ^RingBuffer, elementSizeBytes: rb_size_t, elementCount: rb_size_t, dataPtr: rawptr) -> rb_size_t ---
	FlushRingBuffer :: proc(rbuf: ^RingBuffer) ---
	GetRingBufferWriteAvailable :: proc(rbuf: ^RingBuffer) -> rb_size_t ---
	GetRingBufferReadAvailable :: proc(rbuf: ^RingBuffer) -> rb_size_t ---

	WriteRingBuffer :: proc(rbuf: ^RingBuffer, data: rawptr, elementCount: rb_size_t) -> rb_size_t ---
	ReadRingBuffer :: proc(rbuf: ^RingBuffer, data: rawptr, elementCount: rb_size_t) -> rb_size_t ---

	GetRingBufferWriteRegions :: proc(rbuf: ^RingBuffer, elementCount: rb_size_t, dataPtr1: ^rawptr, sizePtr1: ^rb_size_t, dataPtr2: ^rawptr, sizePtr2: ^rb_size_t) -> rb_size_t ---
	AdvanceRingBufferWriteIndex :: proc(rbuf: ^RingBuffer, elementCount: rb_size_t) -> rb_size_t ---

	GetRingBufferReadRegions :: proc(rbuf: ^RingBuffer, elementCount: rb_size_t, dataPtr1: ^rawptr, sizePtr1: ^rb_size_t, dataPtr2: ^rawptr, sizePtr2: ^rb_size_t) -> rb_size_t ---
	AdvanceRingBufferReadIndex :: proc(rbuf: ^RingBuffer, elementCount: rb_size_t) -> rb_size_t ---

}
