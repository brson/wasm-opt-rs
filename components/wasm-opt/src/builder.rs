//! A builder API for `OptimizationOptions`.

use crate::api::*;

impl OptimizationOptions {
    pub fn reader_file_type(
        &mut self,
        file_type: FileType
    ) -> &mut Self {
        self.reader.file_type = file_type;
        self
    }

    pub fn writer_file_type(
        &mut self,
        file_type: FileType
    ) -> &mut Self {
        self.writer.file_type = file_type;
        self
    }

    // todo
}
