//! DPI awareness is process-wide, so the app turns it on itself.

const std = @import("std");
const builtin = @import("builtin");

/// `DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2`, i.e. `(HANDLE)-4`.
const per_monitor_aware_v2: *anyopaque = @ptrFromInt(std.math.maxInt(usize) - 3);

extern "user32" fn SetProcessDpiAwarenessContext(ctx: *anyopaque) callconv(.winapi) i32;

/// Per-Monitor V2 on Windows; does nothing elsewhere.
///
/// Call before creating any window; a manifest is better for shipped apps.
pub fn awareDpi() void {
    if (builtin.os.tag == .windows) _ = SetProcessDpiAwarenessContext(per_monitor_aware_v2);
}
