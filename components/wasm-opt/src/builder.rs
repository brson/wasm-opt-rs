//! A builder API for `OptimizationOptions`.

use crate::api::*;

/// Builder methods.
impl OptimizationOptions {
    pub fn reader_file_type(&mut self, value: FileType) -> &mut Self {
        self.reader.file_type = value;
        self
    }

    pub fn writer_file_type(&mut self, value: FileType) -> &mut Self {
        self.writer.file_type = value;
        self
    }

    pub fn always_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.always_inline_max_size = value;
        self
    }

    pub fn one_caller_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.one_caller_inline_max_size = value;
        self
    }

    pub fn flexible_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.flexible_inline_max_size = value;
        self
    }

    pub fn allow_functions_with_loops(&mut self, value: bool) -> &mut Self {
        self.inlining.allow_functions_with_loops = value;
        self
    }

    pub fn partial_inlining_ifs(&mut self, value: u32) -> &mut Self {
        self.inlining.partial_inlining_ifs = value;
        self
    }

    // todo
}
