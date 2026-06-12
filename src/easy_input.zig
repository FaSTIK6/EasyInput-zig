const std = @import("std");
const builtin = @import("builtin");

pub const Input = struct {
    // Храним ридер, тип которого библиотека определяет сама
    reader: std.Io.File.Reader,

    /// Создает экземпляр. Принимает только init и ваш буфер из main
    pub fn init(process_init: std.process.Init, buffer: []u8) Input {
        return .{
            // Автоматически связываем системный IO и переданный буфер
            .reader = std.Io.File.stdin().reader(process_init.io, buffer),
        };
    }

    /// Считывает строку текста
    pub fn readLine(self: *Input) !?[]u8 {
        const stdin = &self.reader.interface;
        var line = try stdin.takeDelimiter('\n') orelse return null;

        if (builtin.os.tag == .windows) {
            line = @constCast(std.mem.trimEnd(u8, line, "\r"));
        }
        return line;
    }
};
