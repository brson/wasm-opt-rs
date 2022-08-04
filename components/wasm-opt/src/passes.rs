/// A binaryen optimization pass.
#[derive(Clone, Debug)]
pub enum Pass {
}

impl Pass {
    /// Returns the name of the pass.
    ///
    /// This is the same name used by binaryen to identify the pass on the command line.
    pub fn as_str(&self) -> &'static str {
        todo!()
    }

    /// Get binaryen's description of the pass.
    pub fn description(&self) -> String {
        todo!()
    }
}
